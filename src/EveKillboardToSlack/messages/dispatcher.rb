module EveKillboardToSlack
  module Message
    class Dispatcher
      def initialize(data, params)
        @data = data
        @data[:type] = params[:type]
        dispatch
      end

      def dispatch
        to_services.each do |sender_name|
          formatter = EveKillboardToSlack::Message::Formatter::Formatter
                      .new(@data, sender_name)
          message = formatter.format_message
          sender = sender_instance(sender_name, @data[:type])
          sender.send(message)
        end
      end

      private

      def to_services
        $config['services']['enabled'].map(&:to_sym)
      end

      def sender_instance(to, type)
        class_name = 'EveKillboardToSlack::Message::Sender::'
        class_name += "#{to.downcase.capitalize}Sender"
        Object.const_get(class_name).new(type)
      end
    end
  end
end
