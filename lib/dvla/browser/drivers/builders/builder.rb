module DVLA
  module Browser
    module Drivers
      # https://github.com/teamcapybara/capybara/blob/master/lib/capybara.rb#L80
      class Builder
        class DriverNotImplementedError < StandardError; end

        CONFIG_KEYS = %i[driver browser headless javascript_disabled app_host remote_host proxy_url binary_path
                         emulate_device save_path window_size timeout].freeze
        DRIVERS = %i[cuprite selenium].freeze

        SELENIUM_BROWSERS = %i[chrome firefox edge safari].freeze
        CUPRITE_BROWSERS = %i[chrome].freeze
        BROWSERS = (SELENIUM_BROWSERS + CUPRITE_BROWSERS).uniq.freeze

        def initialize(config = nil)
          # TODO does this need to happen if we split up the selenium class?
          validate_!(config)
          populate_from_!(config)

          @driver ||= nil
          @browser ||= nil

          @app_host ||= 'localhost:3000'

          @headless = true unless instance_variable_defined?(:@headless)
          @javascript_disabled = false unless instance_variable_defined?(:@javascript_disabled)

          @remote_host ||= nil
          @proxy_url ||= nil

          @save_path ||= nil
          @window_size ||= nil
          @timeout ||= nil

          @browser_options ||= {}
          @browser_flags ||= Set.new
        end

        def headless
          @headless = true
          self
        end

        def headed
          @headless = false
          self
        end

        def disable_javascript
          @javascript_disabled = true
          self
        end

        def enable_javascript
          @javascript_disabled = false
          self
        end

        def app_host(url)
          @app_host = url
          self
        end

        def proxy_url(url)
          @proxy_url = url
          self
        end

        def remote_host(url)
          @remote_host = url
          self
        end

        def window_size(height:, width:)
          @window_size = [height, width]
          self
        end

        def timeout(seconds)
          @timeout = seconds.to_i
          self
        end

        def add_browser_option(key, value)
          @browser_options[key] = value
          self
        end

        # TODO: cuprite ignores this, raise a warning or only implement in selenium builder?
        def add_browser_flag(*flags)
          flags.each do |flag|
            flag.prepend('--') unless flag.start_with?('--')
            @browser_flags.add(flag)
          end

          self
        end

        def save_path(path)
          @save_path = path
          self
        end

        def register!(driver_name = @driver)
          raise DriverNotImplementedError, 'Use a specific builder class' unless driver_name

          ::Capybara.app_host = @app_host
          ::Capybara.javascript_driver = driver_name
          ::Capybara.default_driver = driver_name
          ::Capybara.current_driver = driver_name
        end

      private

        # TODO - Collect errors, raise all at once
        def validate_!(config)
          return unless config

          raise ArgumentError, "Config must be a Hash, got #{config.class}" unless config.is_a?(Hash)

          errors = []
          CONFIG_KEYS.each do |key|
            case key
            when :driver
              unless config.key?(:driver)
                errors << 'Config must include a :driver key'
                next
              end

              unless DRIVERS.include?(config[:driver].to_s.downcase.to_sym)
                errors << "Invalid driver: #{config[:driver]}"
              end
            when :browser
              next unless config.key?(:browser)

              unless BROWSERS.include?(config[:browser].to_s.downcase.to_sym)
                errors << "Invalid browser: #{config[:browser]}"
              end
            else
              next
            end
          end

          raise ArgumentError, errors.join('; ') unless errors.empty?

          nil
        end

        def populate_from_!(config)
          return unless config

          CONFIG_KEYS.each do |key|
            key = key.to_s.downcase.to_sym
            next unless config.key?(key)

            value = case key.to_s.downcase.to_sym
                    when :driver, :browser
                      config[key].to_s.downcase.to_sym
                    when :headless, :javascript_disabled
                      config[key].to_s.downcase == 'true'
                    when :timeout
                      config[key].to_i
                    when :browser_flags
                      case config[key]
                      when String
                        config[key].split(',').map(&:strip).to_set
                      when Array
                        config[key].map(&:to_s).map(&:strip).to_set
                      when Set
                        config[key]
                      else
                        next
                      end
                    else
                      config[key]
                    end

            instance_variable_set("@#{key}", value) if config.key?(key)
          end
        end
      end
    end
  end
end
