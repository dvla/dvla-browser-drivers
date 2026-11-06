module DVLA
  module Browser
    module Drivers
      class Firefox < SeleniumBuilder
          def initialize(config = nil)
            super
            @browser = :firefox
          end

          private

          def supports_window_size_via_options? = false
          def supports_device_emulation? = false

          def apply_window_size!(driver)
            return unless @window_size

            height, width = @window_size
            driver.browser.manage.window.resize_to(height, width)
          end

          def apply_proxy_options!
            return unless @proxy_url

            proxy_uri = URI.parse(@proxy_url)
            proxy_host = proxy_uri.host == '0.0.0.0' ? '127.0.0.1' : proxy_uri.host

            add_browser_option('network.proxy.type', 1)
            add_browser_option('network.proxy.http', proxy_host)
            add_browser_option('network.proxy.http_port', proxy_uri.port)
            add_browser_option('network.proxy.ssl', proxy_host)
            add_browser_option('network.proxy.ssl_port', proxy_uri.port)
            add_browser_option('network.proxy.no_proxies_on', '')
          end

          def apply_browser_specific_options!(options)
            options.add_preference('javascript.enabled', false) if @javascript_disabled
          end
        end
    end
  end
end
