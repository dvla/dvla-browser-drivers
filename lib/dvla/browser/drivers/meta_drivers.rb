module DVLA
  module Browser
    module Drivers
      DRIVER_REGEX = /^(?:(?<headless>headless_)(?<driver>selenium_(?<browser>chrome|firefox|edge)|cuprite|apparition)(?<no_js>_no_js)?(?<proxied>_proxied)?|(?<driver_no_headless>selenium_(?<browser_no_headless>chrome|firefox|edge|safari)|cuprite|apparition)(?<no_js_no_headless>_no_js)?(?<proxied_no_headless>_proxied)?)$/

      OTHER_ACCEPTED_PARAMS = %i[timeout browser_options save_path remote proxy window_size].freeze
      OTHER_DRIVERS = %i[cuprite apparition].freeze
      SELENIUM_ACCEPTED_PARAMS = %i[remote additional_arguments additional_preferences binary proxy window_size emulate_device].freeze
      SELENIUM_DRIVERS = %i[selenium_chrome selenium_firefox selenium_edge selenium_safari].freeze

      # Creates methods in the Drivers module that matches the DRIVER_REGEX
      # These methods will register a Driver for use by Capybara in a test pack
      #
      # @example Basic driver
      #   DVLA::Browser::Drivers.chrome
      #
      # @example Driver with additional arguments
      #   DVLA::Browser::Drivers.chrome(remote: 'http://localhost:4444/wd/hub')
      def self.method_missing(method, *args, **kwargs, &)
        matches = method.match(DRIVER_REGEX)
        return super unless matches

        headless = matches[:headless].is_a?(String)
        no_js    = matches[:no_js].is_a?(String) || matches[:no_js_no_headless].is_a?(String)
        proxied  = matches[:proxied].is_a?(String) || matches[:proxied_no_headless].is_a?(String)
        driver   = matches[:driver]&.to_sym || matches[:driver_no_headless]&.to_sym
        browser  = matches[:browser] || matches[:browser_no_headless]

        raise ArgumentError, "Method '#{method}' requires proxy parameter" if proxied && !kwargs[:proxy]

        case driver
        when *SELENIUM_DRIVERS then register_selenium_driver(method, browser.to_sym, headless:, no_js:, **kwargs)
        else                        register_other_driver(method, driver, headless:, no_js:, **kwargs)
        end

        puts "Driver set to: '#{method}'"
        ::Capybara.javascript_driver = method
        ::Capybara.default_driver    = method
        ::Capybara.current_driver    = method
      end

      def self.respond_to_missing?(method, *args)
        method.match(DRIVER_REGEX) || super
      end

      def self.register_selenium_driver(method, browser, headless:, no_js:, **kwargs)
        warn_ignored_kwargs(kwargs, SELENIUM_ACCEPTED_PARAMS)
        puts "Warning: window_size is not supported for #{browser}" if kwargs[:window_size] && browser == :safari
        puts 'Warning: window_size will be overridden by emulate_device' if kwargs[:window_size] && kwargs[:emulate_device]

        ::Capybara.register_driver method do |app|
          options        = build_selenium_options(browser, headless:, no_js:, **kwargs)
          driver_browser = kwargs[:remote] ? :remote : browser
          driver_options = { browser: driver_browser, options: }
          driver_options[:url] = kwargs[:remote] if kwargs[:remote]

          ::Capybara::Selenium::Driver.new(app, **driver_options).tap do |d|
            d.browser.execute_cdp('Emulation.setScriptExecutionDisabled', value: true) if no_js && browser == :edge
            if kwargs[:window_size] && browser == :firefox
              size = parse_window_size(kwargs[:window_size])
              d.browser.manage.window.resize_to(size[0], size[1])
            end
          end
        end
      end
      private_class_method :register_selenium_driver

      def self.register_other_driver(method, driver, headless:, no_js:, **kwargs)
        warn_ignored_kwargs(kwargs, OTHER_ACCEPTED_PARAMS)

        browser_options = { 'no-sandbox': nil, 'disable-smooth-scrolling': true }
        browser_options.merge!(kwargs[:browser_options]) if kwargs[:browser_options]
        browser_options[:'blink-settings'] = 'scriptEnabled=false' if no_js
        if kwargs[:proxy]
          browser_options[:'proxy-server'] = kwargs[:proxy]
          browser_options[:'ignore-certificate-errors'] = nil
        end

        ::Capybara.register_driver method do |app|
          opts = { headless:, timeout: kwargs[:timeout] || 60, browser_options:, save_path: kwargs[:save_path], url: kwargs[:remote] }
          opts[:screen_size] = parse_window_size(kwargs[:window_size]) if kwargs[:window_size]
          Object.const_get("Capybara::#{driver.to_s.capitalize}::Driver").new(app, **opts)
        end
      end
      private_class_method :register_other_driver

      def self.build_selenium_options(browser, headless:, no_js:, **kwargs)
        return Selenium::WebDriver::Safari::Options.new if browser == :safari

        options = Object.const_get("Selenium::WebDriver::#{browser.to_s.capitalize}::Options").new(web_socket_url: true)
        options.binary = kwargs[:binary] if kwargs[:binary]
        options.add_argument('--disable-dev-shm-usage')

        if headless
          options.add_argument('--headless')
          options.add_argument('--no-sandbox')
        end

        apply_selenium_proxy(options, browser, kwargs[:proxy]) if kwargs[:proxy]

        if kwargs[:window_size] && %i[chrome edge].include?(browser)
          size = parse_window_size(kwargs[:window_size])
          options.add_argument("--window-size=#{size[0]},#{size[1]}")
        end

        if kwargs[:emulate_device] && %i[chrome edge].include?(browser)
          emulation = resolve_emulate_device(kwargs[:emulate_device])
          puts "Mobile emulation: #{kwargs[:emulate_device]} | #{emulation[:device_metrics]&.map { |k, v| "#{k}: #{v}" }&.join(', ')}" if emulation[:device_metrics]
          options.add_emulation(**emulation)
        end

        kwargs[:additional_arguments]&.each do |argument|
          argument.prepend('--') unless argument.start_with?('--')
          options.add_argument(argument)
        end

        kwargs[:additional_preferences]&.each do |preference|
          options.add_preference(*preference.first)
        end

        if no_js
          options.add_preference('profile.managed_default_content_settings.javascript', 2) if browser == :chrome
          options.add_preference('javascript.enabled', false) if browser == :firefox
        end

        options
      end
      private_class_method :build_selenium_options

      def self.apply_selenium_proxy(options, browser, proxy)
        if browser == :firefox
          proxy_uri = URI.parse(proxy)
          proxy_host = proxy_uri.host == '0.0.0.0' ? '127.0.0.1' : proxy_uri.host
          options.add_preference('network.proxy.type', 1)
          options.add_preference('network.proxy.http', proxy_host)
          options.add_preference('network.proxy.http_port', proxy_uri.port)
          options.add_preference('network.proxy.ssl', proxy_host)
          options.add_preference('network.proxy.ssl_port', proxy_uri.port)
          options.add_preference('network.proxy.no_proxies_on', '')
          options.add_preference('security.cert_pinning.enforcement_level', 0)
          options.add_preference('security.enterprise_roots.enabled', true)
        else
          options.add_argument("--proxy-server=#{proxy}")
          options.add_argument('--ignore-certificate-errors')
        end
      end
      private_class_method :apply_selenium_proxy

      def self.warn_ignored_kwargs(kwargs, accepted)
        kwargs.each_key do |key|
          puts "Key: '#{key}' will be ignored | Use one from: '#{accepted}'" unless accepted.include?(key)
        end
      end
      private_class_method :warn_ignored_kwargs

      def self.parse_window_size(window_size)
        size = window_size.is_a?(Array) ? window_size : window_size.to_s.split(/[x,]/).map(&:to_i)
        raise ArgumentError, "window_size must have exactly 2 elements [width, height], got: #{window_size.inspect}" unless size.length == 2

        size
      end
      private_class_method :parse_window_size

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
      private_class_method :resolve_emulate_device
    end
  end
end
