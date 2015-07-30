module EveKillboardToSlack
  module Message
    class Formatter
      def initialize(data, params)
        agnostic_data = data_to_agnostic_message(data)
        puts params, agnostic_data
      end

      private

      def data_to_agnostic_message(data)
        {
          id: data['killID'],
          time: Time.parse(data['killTime']).to_s,
          pilot_name: data['victim']['characterName'],
          isk_value: data['zkb']['totalValue'].to_s + ' ISK',
          link: "https://zkillboard.com/kill/#{data['killID']}/"
        }
      end
    end
  end
end
