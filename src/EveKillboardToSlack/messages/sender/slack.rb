module EveKillboardToSlack
  module Message
    module Sender
      class SlackSender
        def initialize(type)
          @type = type
          @slack_client = create_slack_client
        end

        def send(message)
          @slack_client.ping message
        end

        private

        def create_slack_client
          webhook_url = $config['slack']['webhook_url']
          Slack::Notifier.new webhook_url, slack_params
        end

        def loss_params
          slack_params = {
            username: $config['slack']['username'],
            channel: $config['slack']['losses']['channel'],
            icon_emoji: $config['slack']['losses']['emoji']
          }
        end

        def kill_params
          slack_params = {
            username: $config['slack']['username'],
            channel: $config['slack']['kills']['channel'],
            icon_emoji: $config['slack']['kills']['emoji']
          }
        end
      end
    end
  end
end
