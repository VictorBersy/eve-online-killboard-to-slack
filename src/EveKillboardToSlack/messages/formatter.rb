module EveKillboardToSlack
  module Message
    module Formatter
      class Formatter
        def initialize(data, formatter_name)
          @agnostic_data = data_to_agnostic_format(data)
          @formatter_name = formatter_name
        end

        def format_message
          class_name = 'EveKillboardToSlack::Message::Formatter::'
          class_name += "#{@formatter_name.downcase.capitalize}Formatter"
          Object.const_get(class_name).new(@agnostic_data).format
        end

        private

        def data_to_agnostic_format(data)
          kill_link = "https://zkillboard.com/kill/#{data['killID']}/"
          web_page = MetaInspector.new(kill_link)
          {
            type: data[:type],
            id: data['killID'],
            time: Time.parse(data['killTime']),
            pilot_name: data['victim']['characterName'],
            pilot_id: data['victim']['characterID'],
            corporation_name: data['victim']['corporationName'],
            isk_value: split_number(data['zkb']['totalValue'].to_s) + ' ISK',
            link: kill_link,
            web_page: web_page,
            ship_name: web_page.meta['og:title'].split('|')[0].delete(' ')
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
