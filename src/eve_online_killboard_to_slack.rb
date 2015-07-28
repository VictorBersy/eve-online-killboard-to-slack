$LOAD_PATH << File.dirname(__FILE__)

module EveKillboardToSlack
  require 'open-uri'
  require 'json'
  require 'yaml'
  require 'slack-notifier'

  require 'EveKillboardToSlack/boot/loader'
  require 'EveKillboardToSlack/zkillboard/zkillboard'
  Boot::Boot.new
end
