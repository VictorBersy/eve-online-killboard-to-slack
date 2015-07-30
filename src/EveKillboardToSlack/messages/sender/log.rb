module EveKillboardToSlack
  module Message
    module Sender
      class LogMessenger
        def initialize
        end

        def send(message)
          puts message
        end
      end
    end
  end
end
