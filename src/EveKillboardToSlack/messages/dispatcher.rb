module EveKillboardToSlack
  module Message
    class Dispatcher
      def initialize(data, params)
        data[:type] = params[:type]
        params[:to].push(:log).each do |sender_name|
          formatter = EveKillboardToSlack::Message::Formatter::Formatter
                      .new(data, sender_name)
          message = formatter.format_message
          sender = sender_instance(sender_name, params[:type])
          sender.send(message)
        end
      end

      private

      def sender_instance(to, type)
        class_name = 'EveKillboardToSlack::Message::Sender::'
        class_name += "#{to.downcase.capitalize}Sender"
        Object.const_get(class_name).new(type)
      end
    end
  end
end
