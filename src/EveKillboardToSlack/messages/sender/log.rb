module EveKillboardToSlack
  module Message
    module Sender
      class LogSender
        def initialize(_type)
        end

        def send(message)
          puts message[:colored]
          Tools.logger.info message[:raw]
        end
      end
    end
  end
end
