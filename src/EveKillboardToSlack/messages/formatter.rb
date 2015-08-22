module EveKillboardToSlack
  module Message
    module Formatter
      class Formatter
        def initialize(data, formatter_name)
          @agnostic_data = data_to_agnostic_format(data)
          @formatter_name = formatter_name
        end

        def format_message
          class_name = "EveKillboardToSlack::Message::Formatter::"
          class_name += "#{@formatter_name.downcase.capitalize}Formatter"
          Object.const_get(class_name).new(@agnostic_data).format
        end

        private

        def data_to_agnostic_format(data)
          {
            type: data[:type],
            id: data['killID'],
            time: Time.parse(data['killTime']),
            pilot_name: data['victim']['characterName'],
            corporation_name: data['victim']['corporationName'],
            isk_value: split_number(data['zkb']['totalValue'].to_s) + ' ISK',
            link: "https://zkillboard.com/kill/#{data['killID']}/"
          }
        end

        def split_number(number)
          numbers = number.split('.')
          integer = numbers[0].reverse.scan(/.{1,3}/).join(' ').reverse
          float = numbers[1] || '00'
          [integer, float].join('.')
        end
      end
    end
  end
end
