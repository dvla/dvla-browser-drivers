module DVLA
  module Browser
    module Drivers
      class CupriteBuilder < Builder
        def initialize(config = nil)
          super

          @driver = :cuprite
          @browser = :chrome

          add_browser_option('no-sandbox', nil)
          add_browser_option('disable-smooth-scrolling', true)

          @timeout = 60
        end

        def build!
          add_browser_option('blink-settings', 'scriptEnabled=false') if @javascript_disabled

          if @proxy_url
            add_browser_option('proxy-server', @proxy_url)
            add_browser_option('ignore-certificate-errors', nil)
          end

          ::Capybara.register_driver :cuprite do |app|
            opts = { headless: @headless,
                     timeout: @timeout,
                     browser_options: @browser_options,
                     save_path: @save_path,
                     url: @remote_host }

            opts[:window_size] = @window_size if @window_size

            ::Capybara::Cuprite::Driver.new(app, **opts)
          end
          DVLA::Browser::Drivers.logger.info { "Driver built - driver: #{@driver}, browser: #{@browser}, headless: #{@headless}, javascript disabled: #{@javascript_disabled}, browser options: #{@browser_options}, proxy: #{@proxy_url}" }

          super
        end
      end
    end
  end
end
