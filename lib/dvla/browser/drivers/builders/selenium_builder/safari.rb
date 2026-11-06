module DVLA
  module Browser
    module Drivers

      class Safari < SeleniumBuilder
          SUPPORTED_OPTIONS = %i[app_host remote_host timeout].freeze
          UNSUPPORTED_OPTIONS = ALL_OPTIONS - SUPPORTED_OPTIONS.freeze

          UNSUPPORTED_OPTIONS.each do |attribute|
            define_method(attribute) { puts "#{attribute} can't be called on #{self}"; self }
          end

          def initialize(config = nil)
            super
            @browser = :safari
            @headless = false
            @emulate_device = false
          end

          private

          def build_selenium_options
            Selenium::WebDriver::Safari::Options.new
          end
        end

    end
  end
end
