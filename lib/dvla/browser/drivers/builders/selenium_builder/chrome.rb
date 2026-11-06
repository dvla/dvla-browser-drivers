module DVLA
  module Browser
    module Drivers
        class Chrome < SeleniumBuilder
          def initialize(config = nil)
            super
            @browser = :chrome
          end

          def emulate(device = MOBILE_PROFILES.sample)
            if MOBILE_PROFILES.include?(device)
              profile = MOBILE_PROFILES[device]
              DVLA::Browser::Drivers.logger.info { "Emulating device: #{device}" }
              @emulate_device = {
                device_metrics: { width: profile[:width], height: profile[:height], pixelRatio: profile[:device_scale_factor], touch: profile[:has_touch] },
                user_agent: profile[:user_agent],
              }
              self
            else
              raise ArgumentError, "Unknown mobile profile: '#{device}'. Available: #{MOBILE_PROFILES.keys.map { |k| ":#{k}" }.join(', ')}"
            end
          end

          private

          def supports_window_size_via_options? = true
          def supports_device_emulation? = true

          def apply_browser_specific_options!(options)
            options.add_preference('profile.managed_default_content_settings.javascript', 2) if @javascript_disabled
          end
        end
    end
  end
end
