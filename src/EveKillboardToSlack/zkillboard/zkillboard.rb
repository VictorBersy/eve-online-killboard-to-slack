module EveKillboardToSlack
  module Zkillboard
    class Zkillboard
      def initialize
        @losses_url = $config['zkillboard']['losses_url']
        retrieve_losses
      end

      def retrieve_losses
        last_loss_id = $database[:last_loss_id].to_s
        @losses_url = append_zk_param(@losses_url, 'afterKillID', last_loss_id)
        json_data = JSON.parse(open(@losses_url).read)
        split_data(json_data)
      end

      private

      def append_zk_param(url, param_name, value)
        return url if value.empty?
        [url, '/', param_name, '/', value, '/'].join
      end

      def split_data(json_data)
        json_data.each do |data|
          format_message(data)
        end
      end

      def format_message(data)
        loss_id         = data['killID']
        date            = Time.parse(data['killTime']).to_s
        pilot_name      = data['victim']['characterName']
        totalValue      = data['zkb']['totalValue'].to_s + ' ISK'
        zkillboard_link = "https://zkillboard.com/kill/#{loss_id}/"

        message = "New loss : [#{date} : #{pilot_name} / #{totalValue}](#{zkillboard_link})"
        EveKillboardToSlack::Message::Dispatcher.new(message, to: [:slack])
      end
    end
  end
end
