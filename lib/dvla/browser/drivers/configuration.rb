module DVLA
  module Browser
    module Drivers
      class Configuration
        # TODO: Should we have a setting for log level?
        # Set a custom logger
        # @param new_logger [Logger]
        def logger=(new_logger)
          if new_logger.is_a?(Logger)
            @logger = new_logger
          else
            warn("[WARN] Custom logger is not an instance of Logger: '#{new_logger.class}'")
          end
        end

        def logger
          if @logger
            @logger
          else
            @logger = Logger.new($stdout)
          end
        end
      end
    end
  end
end
