module DVLA
  module Browser
    module Drivers
      class SeleniumBuilder < Builder
        class BrowserNotSupportedError < StandardError; end

        BROWSER_SUBCLASSES = { chrome: 'Chrome', firefox: 'Firefox', edge: 'Edge', safari: 'Safari' }.freeze

        SUPPORTED_OPTIONS = %i[headless javascript_disabled app_host remote_host proxy_url binary_path window_size
                               timeout emulate_device].freeze

        def self.new(config = nil)
          browser = config.is_a?(Hash) ? config[:browser]&.to_sym : nil

          if browser && BROWSER_SUBCLASSES.key?(browser) && self.superclass == SeleniumBuilder
            subclass = const_get(BROWSER_SUBCLASSES[browser])
            return subclass.new(config)
          end

          super
        end

        def initialize(config = nil)
          super

          add_browser_flag('--disable-dev-shm-usage')

          @driver = :selenium
          @browser = :chrome if @browser.nil?

          @binary_path ||= nil
          @emulate_device ||= nil
        end

        def firefox = Firefox.new(current_config)
        def chrome   = Chrome.new(current_config)
        def edge     = Edge.new(current_config)
        def safari   = Safari.new(current_config)

        def binary_path(path)
          @binary_path = path
          self
        end

        # def emulate(_device = nil)
        #   # TODO should we be warning or just throwing if they aren't supported
        #   puts "You can't call that method on #{self.class} browser"
        #   self
        #   # raise BrowserNotSupportedError, "#{@browser} does not support device emulation"
        # end

        def register!
          Capybara.configure do |config|
            config.session_options.default_set_options = { clear: :backspace }
          end

          ::Capybara.register_driver(driver_name) do |app|
            browser = @remote_host.nil? ? @browser : :remote

            driver_options = { browser:,
                               url: @remote_host,
                               options: build_selenium_options }

            ::Capybara::Selenium::Driver.new(app, **driver_options).tap do |driver|
              apply_js_disabled!(driver)
              apply_window_size!(driver)
            end
          end

          warn_unsupported_options!
          DVLA::Browser::Drivers.logger.info { "Driver registered - driver: #{@driver}, browser: #{@browser}, headless: #{@headless}, javascript disabled: #{@javascript_disabled}, browser options: #{@browser_flags + @browser_options}#{", proxy: #{@proxy_url}" if @proxy_url}#{", remote_host: #{@remote_host}" if @remote_host}" }

          super(driver_name)
        end

      private

        def driver_name
          :"selenium_#{@browser}"
        end

        def supported_options = self.class::SUPPORTED_OPTIONS

        def warn_unsupported_options!
          # { headless: @headless, javascript_disabled: @javascript_disabled, proxy_url: @proxy_url,
          #   binary_path: @binary_path, window_size: @window_size, emulate_device: @emulate_device }.each do |option, value|
          #   next unless value && !supported_options.include?(option)
          #
          #   DVLA::Browser::Drivers.logger.warn { "#{option} is not supported by #{@browser}" }
          # end
        end

        # Hook: override in subclasses that support window size via browser arguments
        def supports_window_size_via_options? = false

        # Hook: override in subclasses that support device emulation
        def supports_device_emulation? = false

        # Hook: override in subclasses with browser-specific post-driver-creation JS disabling
        def apply_js_disabled!(_driver) = nil

        # Hook: override in subclasses with browser-specific post-driver-creation window sizing
        def apply_window_size!(_driver) = nil

        # Hook: override in subclasses with browser-specific proxy options
        def apply_proxy_options!
          return unless @proxy_url

          add_browser_flag("--proxy-server=#{@proxy_url}")
        end

        # Hook: override in subclasses with browser-specific options/preferences
        def apply_browser_specific_options!(_options) = nil

        def build_selenium_options
          # TODO do we want BiDi on by default or an option?
          options = Object.const_get("Selenium::WebDriver::#{@browser.to_s.capitalize}::Options")
                          .new(web_socket_url: true)

          options.binary = @binary_path if @binary_path

          add_browser_flag('--headless', '--no-sandbox') if @headless
          add_browser_flag("--window-size=#{@window_size[0]},#{@window_size[1]}") if @window_size && supports_window_size_via_options?

          apply_proxy_options!
          options.accept_insecure_certs = true if @proxy_url

          options.add_emulation(**@emulate_device) if @emulate_device && supports_device_emulation?

          apply_browser_specific_options!(options)

          @browser_flags.each { |flag| options.add_argument(flag) }
          @browser_options.each { |k, v| options.add_preference(k, v) }

          options
        end

        def current_config
          { driver: @driver,
            headless: @headless,
            javascript_disabled: @javascript_disabled,
            app_host: @app_host,
            remote_host: @remote_host,
            proxy_url: @proxy_url,
            binary_path: @binary_path,
            window_size: @window_size,
            timeout: @timeout }.compact
        end
      end
    end
  end
end

require_relative 'selenium_builder/chrome'
require_relative 'selenium_builder/firefox'
require_relative 'selenium_builder/edge'
require_relative 'selenium_builder/safari'
