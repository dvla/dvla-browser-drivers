require_relative 'drivers/meta_drivers'
require_relative 'drivers/version'

require 'capybara/apparition'
require 'capybara/cuprite'
require 'dvla/herodotus'
require 'selenium-webdriver'

module DVLA
  class Error < StandardError; end

  DVLA::Herodotus.configure do |config|
    config.system_name = 'browser-drivers'
    config.pid = true
  end

  LOG = DVLA::Herodotus.logger
end
