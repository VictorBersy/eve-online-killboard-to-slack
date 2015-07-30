module EveKillboardToSlack
  module Message
    class SlackMessenger
      def initialize
        slack_params = {
          channel: $config['slack']['channel'],
          username: $config['slack']['username'],
          icon_emoji: ':skull:'
        }
        webhook_url = $config['slack']['webhook_url']
        @slack_client = Slack::Notifier.new webhook_url, slack_params
      end

      def send(message)
        @slack_client.ping message
      end
    end
  end
end
