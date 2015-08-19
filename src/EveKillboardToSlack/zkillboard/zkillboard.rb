module EveKillboardToSlack
  module Zkillboard
    class Zkillboard
      def initialize
        @last_loss_id = {}
        retrieve_losses($config['zkillboard']['losses_url'])
        retrieve_kills($config['zkillboard']['kills_url'])
      end

      def retrieve_kills(url)
        retrieve_data(:kill, url)
      end

      def retrieve_losses(url)
        retrieve_data(:loss, url)
      end

      def retrieve_data(type, url)
        last_id = $database.get("last_#{type}_id")
        url = append_zk_param(url, 'afterKillID', last_id)
        json_data = JSON.parse(open(url).read)
        split_data(json_data, type.to_sym)
      end

      private

      def append_zk_param(url, param_name, value)
        return url if value.empty?
        [url, '/', param_name, '/', value, '/'].join
      end

      def split_data(json_data, type)
        json_data.each do |data|
          save_last_id(data['killID'], type)
          format_message(data, type)
        end
      end

      def format_message(data, type)
        params = { type: type }
        EveKillboardToSlack::Message::Dispatcher.new(data, params)
      end

      def save_last_id(last_id, type)
        $database.set("last_#{type}_id", last_id) unless @last_loss_id[type]
        @last_loss_id[type] = last_id
      end
    end
  end
end
