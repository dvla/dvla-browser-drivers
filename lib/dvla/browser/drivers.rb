require_relative 'drivers/mobile_profiles'
require_relative 'drivers/meta_drivers'
require_relative 'drivers/version'

require 'capybara/apparition'
require 'capybara/cuprite'
require 'selenium-webdriver'

module DVLA
  class Error < StandardError; end
end
