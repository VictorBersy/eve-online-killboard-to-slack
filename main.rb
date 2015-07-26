require 'open-uri'
require 'json'
require 'yaml'
require 'slack-notifier'


class Main
  def initialize
    @database = YAML::load_file(File.join(__dir__, 'database.yml'))
    @config   = YAML::load_file(File.join(__dir__, 'config.yml'))
    send_losses(parse_losses)
    save_database
  end

  def parse_losses
    losses_url = try_after_kill_id(@config['zkillboard']['losses_url'])
    JSON.parse(open(losses_url).read)
  end

  def send_losses(losses)
    losses.each do |loss_json|
      send_slack_alert(loss_json)
      @last_loss_id ||= loss_json['killID']
    end
  end

  def send_slack_alert(loss)
    loss_id         = loss['killID']
    date            = Time.parse(loss['killTime']).to_s
    pilot_name      = loss['victim']['characterName']
    totalValue      = loss['zkb']['totalValue'].to_s + ' ISK'
    zkillboard_link = "https://zkillboard.com/kill/#{loss_id}/"

    message = "New loss : [#{date} : #{pilot_name} / #{totalValue}](#{zkillboard_link})"

    dispatch_message(message)
  end

  def save_database
    d = {
      last_loss_id: @last_loss_id
    }
    file_path = File.join(__dir__, 'database.yml')
    File.open(file_path, 'w') { |f| f.write d.to_yaml }
  end

  private

  def dispatch_message(message)
    puts message
    slack_notifier.ping message
  end

  def slack_notifier
    slack_params = {
      channel: @config['slack']['channel'],
      username: @config['slack']['username'],
      icon_emoji: ':fire:'
    }
    Slack::Notifier.new @config['slack']['webhook_url'], slack_params
  end

  def try_after_kill_id(url)
    last_loss_id = @database[:last_loss_id].to_s
    url + "afterKillID/#{last_loss_id}/" unless last_loss_id.empty?
  end
end

Main.new
