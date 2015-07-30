module EveKillboardToSlack
  module Message
    module Formatter
      class Formatter
        def initialize(data, formatter_name)
          @agnostic_data = data_to_agnostic_format(data)
          @formatter_name = formatter_name
        end

        def format_message
          class_name = "EveKillboardToSlack::Message::Formatter::#{@formatter_name.downcase.capitalize}Formatter"
          Object.const_get(class_name).new(@agnostic_data).format
        end

        private

        def data_to_agnostic_format(data)
          {
            type: data[:type],
            id: data['killID'],
            time: Time.parse(data['killTime']),
            pilot_name: data['victim']['characterName'],
            isk_value: data['zkb']['totalValue'].to_s + ' ISK',
            link: "https://zkillboard.com/kill/#{data['killID']}/"
          }
        end
      end
    end
  end
end
