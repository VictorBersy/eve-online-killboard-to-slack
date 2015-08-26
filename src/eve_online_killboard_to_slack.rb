$LOAD_PATH << File.dirname(__FILE__)

module EveKillboardToSlack
  require 'open-uri'
  require 'json'
  require 'yaml'
  require 'slack-notifier'
  require 'logger'
  require 'rainbow'
  require 'metainspector'

  require 'EveKillboardToSlack/boot/loader'
  Boot::Boot.new
end
