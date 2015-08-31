module EveKillboardToSlack
  module Boot
    class Boot
      def initialize
        Tools.logger.debug "Starting script at #{Time.now.utc}"
        Zkillboard::Zkillboard.new
      end
    end
  end
end
