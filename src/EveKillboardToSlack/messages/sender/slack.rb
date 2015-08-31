module EveKillboardToSlack
  module Message
    module Sender
      class SlackSender
        def initialize(type)
          @type = type
          @slack_client = create_slack_client
        end

        def send(message)
          params = { attachments: [message[:attachment]] }
          @slack_client.ping('', params)
        end

        def create_slack_client
          slack_params = method("#{@type}_params".to_sym).call
          webhook_url = Tools.config['slack']['webhook_url']
          Slack::Notifier.new webhook_url, slack_params
        end

        def loss_params
          {
            username: Tools.config['slack']['username'],
            channel: Tools.config['slack']['losses']['channel'],
            icon_emoji: Tools.config['slack']['losses']['emoji']
          }
        end

        def kill_params
          {
            username: Tools.config['slack']['username'],
            channel: Tools.config['slack']['kills']['channel'],
            icon_emoji: Tools.config['slack']['kills']['emoji']
          }
        end
      end
    end
  end
end
