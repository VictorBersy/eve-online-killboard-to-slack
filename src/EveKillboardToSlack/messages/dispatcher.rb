module EveKillboardToSlack
  module Message
    class Dispatcher
      def initialize(message, params)
        # The log messenger is explicitly added
        params[:to].push(:log).each do |messenger_name|
          messenger = messenger_instance(messenger_name)
          messenger.send(message)
        end
      end

      private

      def messenger_instance(to)
        class_name = "EveKillboardToSlack::Message::#{to.downcase.capitalize}Messenger"
        Object.const_get(class_name).new
      end
    end
  end
end
