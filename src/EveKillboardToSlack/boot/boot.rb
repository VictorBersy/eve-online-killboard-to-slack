module EveKillboardToSlack
  module Boot
    class Boot
      def initialize
        set_global_vars
        Zkillboard::Zkillboard.new
      end

      def set_global_vars
        $root_path = File.expand_path(File.join(__dir__, '..', '..', '..'))
        $database  = EveKillboardToSlack::Database.new
        $config    = YAML::load_file(File.join($root_path, 'config', 'config.yml'))
        $logger    = Logger.new(File.join($root_path, 'logs', 'log.txt'))
      end
    end
  end
end
