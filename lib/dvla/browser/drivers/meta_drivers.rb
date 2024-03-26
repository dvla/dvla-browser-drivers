module DVLA
  module Browser
    module Drivers
      DRIVER_REGEX = /^(?:(?<headless>headless)_)?(?<browser>chrome|firefox|edge|cuprite|apparition)$/

      OTHER_ACCEPTED_PARAMS = %i[timeout].freeze
      OTHER_DRIVERS = %i[cuprite apparition].freeze
      SELENIUM_ACCEPTED_PARAMS = %i[remote additional_options additional_preferences].freeze
      SELENIUM_DRIVERS = %i[chrome firefox edge].freeze

      # Creates methods in the Drivers module that matches the DRIVER_REGEX
      # These methods will register a Driver for use by Capybara in a test pack
      #
      # @example Basic driver
      #   DVLA::Browser::Drivers.chrome
      #
      # @example Driver with additional arguments
      #   DVLA::Browser::Drivers.chrome(remote: 'http://localhost:4444/wd/hub')
      def self.method_missing(method, *args, **kwargs, &block)
        if (matches = method.match(DRIVER_REGEX))
          headless = matches[:headless].is_a? String
          browser = matches[:browser].to_sym

          case browser
          when *SELENIUM_DRIVERS
            kwargs.each do |key, _value|
              LOG.warn { "Key: '#{key}' will be ignored | Use one from: '#{SELENIUM_ACCEPTED_PARAMS}'" } unless SELENIUM_ACCEPTED_PARAMS.include?(key)
            end

            Capybara.register_driver method do |app|
              options = Object.const_get("Selenium::WebDriver::#{browser.to_s.capitalize}::Options").new
              options.add_argument('--disable-dev-shm-usage')

              if headless
                options.add_argument('--headless')
                options.add_argument('--no-sandbox')
              end

              browser = :remote if kwargs[:remote]

              if kwargs[:additional_options]
                kwargs[:additional_options].each do |additional_option|
                  additional_option.prepend('--') unless additional_option.start_with?('--')
                  options.add_argument(additional_option)
                end
              end

              if kwargs[:additional_preferences]
                kwargs[:additional_preferences].each do |preference|
                  key, value = preference.first
                  options.add_preference(key, value)
                end
              end

              Capybara::Selenium::Driver.new(app, url: kwargs[:remote], browser:, options:)
            end
          else
            kwargs.each do |key, _value|
              LOG.warn { "Key: '#{key}' will be ignored | Use one from: '#{OTHER_ACCEPTED_PARAMS}'" } unless OTHER_ACCEPTED_PARAMS.include?(key)
            end

            Capybara.register_driver method do |app|
              Object.const_get("Capybara::#{browser.to_s.capitalize}::Driver").new(
                app,
                headless:,
                timeout: kwargs[:timeout] || 30,
                browser_options: { 'no-sandbox': nil, 'disable-smooth-scrolling': true },
              )
            end
          end

          LOG.info("Driver set to: '#{method}'")
          Capybara.default_driver = method
          Capybara.current_driver = method
        else
          super.method_missing(method, *args, &block)
        end
      end

      def self.respond_to_missing?(method, *args)
        method.match(DRIVER_REGEX) || super
      end
    end
  end
end
