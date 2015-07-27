$LOAD_PATH << File.dirname(__FILE__)

module EveKillboardToSlack
  require 'open-uri'
  require 'json'
  require 'yaml'
  require 'slack-notifier'

  require 'EveKillboardToSlack/boot/loader'
end
