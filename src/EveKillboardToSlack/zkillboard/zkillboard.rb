module EveKillboardToSlack
  module Zkillboard
    class Zkillboard
      def initialize
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
        last_id = $database["last_#{type}_id".to_sym].to_s
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
          format_message(data, type)
        end
      end

      def format_message(data, type)
        params = { to: [:slack], type: type }
        EveKillboardToSlack::Message::Dispatcher.new(data, params)
      end
    end
  end
end
