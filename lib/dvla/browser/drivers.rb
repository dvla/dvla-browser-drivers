require_relative 'drivers/builders/builder'
require_relative 'drivers/builders/cuprite_builder'
require_relative 'drivers/builders/selenium_builder'

require_relative 'drivers/mobile_profiles'
require_relative 'drivers/meta_drivers'
require_relative 'drivers/version'

require 'capybara/apparition'
require 'capybara/cuprite'
require 'selenium-webdriver'

module DVLA
  module Browser
    module Drivers
      def self.cuprite_builder(config = nil)
        CupriteBuilder.new(config)
      end

      def self.selenium_builder(config = nil)
        SeleniumBuilder.new(config)
      end

      def self.builder(driver, config: nil)
        case driver.to_s.downcase.to_sym
        when :cuprite
          CupriteBuilder.new(config)
        else
          SeleniumBuilder.new(config)
        end
      end

      def self.logger
        @logger ||= if defined?(LOG) && LOG.respond_to?(:spawn_child_logger)
                      LOG.spawn_child_logger(system_name: 'Browser Drivers')
                    else
                      DVLA::Herodotus.logger('Browser Drivers')
                    end
        @logger.level = defined?(LOG) ? LOG.level : 0
        @logger
      end
    end
  end
end
