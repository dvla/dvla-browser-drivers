module DVLA
  module Browser
    module Drivers
      class SeleniumBuilder < Builder
        def initialize(config = nil)
          super

          define_emulation_profile_methods!

          add_browser_flag('--disable-dev-shm-usage')

          @driver = :selenium
          @browser = :chrome if @browser.nil?

          @binary_path ||= nil
          @emulate_device ||= nil
        end

        def firefox
          @browser = :firefox
          self
        end

        def chrome
          @browser = :chrome
          self
        end

        def edge
          @browser = :edge
          self
        end

        def safari
          @browser = :safari
          self
        end

        def binary_path(path)
          @binary_path = path
          self
        end

        def build!
          # puts "Warning: window_size is not supported for #{browser}" if kwargs[:window_size] && browser == :safari
          # puts 'Warning: window_size will be overridden by emulate_device' if kwargs[:window_size] && kwargs[:emulate_device]

          ::Capybara.register_driver driver_name do |app|
            browser = @remote_host.nil? ? @browser : :remote

            driver_options = { browser:,
                               url: @remote_host,
                               options: build_selenium_options }

            ::Capybara::Selenium::Driver.new(app, **driver_options).tap do |driver|
              if @javascript_disabled && browser == :edge
                driver.browser.execute_cdp('Emulation.setScriptExecutionDisabled', value: true)
              end

              if @window_size && browser == :firefox
                height, width = @window_size
                driver.browser.manage.window.resize_to(height, width)
              end
            end
          end
          DVLA::Browser::Drivers.logger.info { "Driver built - driver: #{@driver}, browser: #{@browser}, headless: #{@headless}, javascript disabled: #{@javascript_disabled}, browser options: #{@browser_flags + @browser_options}" }

          super(driver_name)
        end

        private

        def define_emulation_profile_methods!
          MOBILE_PROFILES.each do |name, profile|
            define_singleton_method("emulate_#{name}") do
              @emulate_device = profile
              self
            end
          end
        end

        def driver_name
          "selenium_#{@browser}".to_sym
        end

        def supports_window_size_via_options?
          %i[chrome edge].include?(@browser)
        end

        def supports_device_emulation?
          %i[chrome edge].include?(@browser)
        end

        def apply_selenium_proxy_options!
          return unless @proxy_host

          if @browser == :firefox
            proxy_uri = URI.parse(@proxy_host)
            proxy_host = proxy_uri.host == '0.0.0.0' ? '127.0.0.1' : proxy_uri.host

            add_browser_option('network.proxy.type', 1)
            add_browser_option('network.proxy.http', proxy_host)
            add_browser_option('network.proxy.http_port', proxy_uri.port)
            add_browser_option('network.proxy.ssl', proxy_host)
            add_browser_option('network.proxy.ssl_port', proxy_uri.port)
            add_browser_option('network.proxy.no_proxies_on', '')
            add_browser_option('security.cert_pinning.enforcement_level', 0)
            add_browser_option('security.enterprise_roots.enabled', true)
          else
            add_browser_flag("--proxy-server=#{@proxy_host}")
            add_browser_flag('--ignore-certificate-errors')
          end
        end

        def self.resolve_emulate_device(emulate_device)
          if emulate_device.is_a?(Symbol)
            profile = MOBILE_PROFILES[emulate_device]
            raise ArgumentError, "Unknown mobile profile: ':#{emulate_device}'. Available: #{MOBILE_PROFILES.keys.map { |k| ":#{k}" }.join(', ')}" unless profile

            {
              device_metrics: { width: profile[:width], height: profile[:height], pixelRatio: profile[:device_scale_factor], touch: profile[:has_touch] },
              user_agent: profile[:user_agent]
            }
          else
            emulate_device.transform_keys(&:to_sym)
          end
        end

        def build_selenium_options
          return Selenium::WebDriver::Safari::Options.new if @browser == :safari

          options = Object.const_get("Selenium::WebDriver::#{@browser.to_s.capitalize}::Options")
                          .new(web_socket_url: true) # web_socket_url is for BIDI support

          options.binary = @binary_path if @binary_path

          add_browser_flag('--headless', '--no-sandbox') if @headless
          add_browser_flag("--window-size=#{@window_size[0]},#{@window_size[1]}") if @window_size && supports_window_size_via_options?

          apply_selenium_proxy_options!

          options.add_emulation(**@emulate_device) if @emulate_device && supports_device_emulation?

          if @javascript_disabled
            add_browser_option('javascript.enabled', false) if @browser == :firefox
            add_browser_option('profile.managed_default_content_settings.javascript', 2) if @browser == :chrome
          end

          @browser_flags.each { |flag| options.add_argument(flag) }
          @browser_options.each { |k, v| options.add_preference(k, v) }

          options
        end
      end
    end
  end
end