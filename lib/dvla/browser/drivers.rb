require_relative 'drivers/meta_drivers'
require_relative 'drivers/version'

require 'capybara/apparition'
require 'capybara/cuprite'
require 'dvla/herodotus'
require 'selenium-webdriver'

module DVLA
  class Error < StandardError; end
  
  main_logger = DVLA::Herodotus.logger('browser-drivers', config: config)
end
