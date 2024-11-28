module DVLA
  module Browser
    module Drivers
      DRIVER_REGEX = /^(?:(?<headless>headless)_)?(?<driver>(selenium_(?<browser>chrome|firefox|edge)|cuprite|apparition))$/

      OTHER_ACCEPTED_PARAMS = %i[timeout browser_options save_path remote].freeze
      OTHER_DRIVERS = %i[cuprite apparition].freeze
      SELENIUM_ACCEPTED_PARAMS = %i[remote additional_arguments additional_preferences].freeze
      SELENIUM_DRIVERS = %i[selenium_chrome selenium_firefox selenium_edge].freeze

      # Creates methods in the Drivers module that matches the DRIVER_REGEX
      # These methods will register a Driver for use by Capybara in a test pack
      #
      # @example Basic driver
      #   DVLA::Browser::Drivers.chrome
      #
      # @example Driver with additional arguments
      #   DVLA::Browser::Drivers.chrome(remote: 'http://localhost:4444/wd/hub')
      def self.method_missing(method, *args, **kwargs, &)
        if (matches = method.match(DRIVER_REGEX))
          headless = matches[:headless].is_a? String
          driver = matches[:driver].to_sym

          case driver
          when *SELENIUM_DRIVERS
            browser = matches[:browser].to_sym

            kwargs.each do |key, _value|
              LOG.warn { "Key: '#{key}' will be ignored | Use one from: '#{SELENIUM_ACCEPTED_PARAMS}'" } unless SELENIUM_ACCEPTED_PARAMS.include?(key)
            end

            ::Capybara.register_driver method do |app|
              options = Object.const_get("Selenium::WebDriver::#{browser.to_s.capitalize}::Options").new
              options.add_argument('--disable-dev-shm-usage')

              if headless
                options.add_argument('--headless')
                options.add_argument('--no-sandbox')
              end

              browser = :remote if kwargs[:remote]

              kwargs[:additional_arguments] && kwargs[:additional_arguments].each do |argument|
                argument.prepend('--') unless argument.start_with?('--')
                options.add_argument(argument)
              end

              kwargs[:additional_preferences] && kwargs[:additional_preferences].each do |preference|
                key, value = preference.first
                options.add_preference(key, value)
              end

              ::Capybara::Selenium::Driver.new(app, url: kwargs[:remote], browser:, options:)
            end
          else
            kwargs.each do |key, _value|
              LOG.warn { "Key: '#{key}' will be ignored | Use one from: '#{OTHER_ACCEPTED_PARAMS}'" } unless OTHER_ACCEPTED_PARAMS.include?(key)
            end

            browser_options = { 'no-sandbox': nil, 'disable-smooth-scrolling': true }
            kwargs[:browser_options] && kwargs[:browser_options].each do |key, value|
              browser_options[key] = value
            end

            ::Capybara.register_driver method do |app|
              Object.const_get("Capybara::#{driver.to_s.capitalize}::Driver").new(
                app,
                headless:,
                timeout: kwargs[:timeout] || 60,
                browser_options:,
                save_path: kwargs[:save_path],
                url: kwargs[:remote],
              )
            end
          end

          LOG.info { "Driver set to: '#{method}'" }

          ::Capybara.javascript_driver = method
          ::Capybara.default_driver = method
          ::Capybara.current_driver = method
        else
          super.method_missing(method, *args, &)
        end
      end

      def self.respond_to_missing?(method, *args)
        method.match(DRIVER_REGEX) || super
      end
    end
  end
end
