require_relative 'drivers/builders/builder'
require_relative 'drivers/builders/cuprite_builder'
require_relative 'drivers/builders/selenium_builder'

require_relative 'drivers/configuration'
require_relative 'drivers/mobile_profiles'
require_relative 'drivers/meta_drivers'
require_relative 'drivers/version'

require 'capybara/apparition'
require 'capybara/cuprite'
require 'selenium-webdriver'

module DVLA
  module Browser
    module Drivers
      # DVLA::Browser::Drivers.register_driver_from_config('settings.yml')
      #
      # DVLA::Browser::Drivers.cuprite.headless.register!

      def self.cuprite_builder(config = nil)
        CupriteBuilder.new(config)
      end

      def self.selenium_builder(config = nil)
        SeleniumBuilder.new(config)
      end

      # TODO: Use as method for building from config,
      def self.register_from_config!(config: nil)
        raise unless config.is_a? Hash

        driver = config[:driver].to_sym
        case driver
        when :cuprite
          CupriteBuilder.new(config).register!
        when :selenium
          # Or :selenium_firefox, :selenium_chrome?
          SeleniumBuilder.new(config).register!
        else
          raise "Unknown driver #{driver}"
        end
      end

      def self.config
        @config ||= Configuration.new
      end

      def self.logger
        @logger ||= config.logger
      end
    end
  end
end
