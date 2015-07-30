module EveKillboardToSlack
  module Message
    module Sender
      class LogSender
        def initialize(type)
        end

        def send(message)
          puts message
        end
      end
    end
  end
end
