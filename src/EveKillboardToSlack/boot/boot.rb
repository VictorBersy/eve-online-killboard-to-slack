module EveKillboardToSlack
  module Boot
    class Boot
      def initialize
        set_global_vars
        @zkillboard = Zkillboard::Zkillboard.new
      end

      def set_global_vars
        $root_path = File.expand_path(File.join(__dir__, '..', '..', '..'))
        $database  = YAML::load_file(File.join($root_path, 'config', 'database.yml'))
        $config    = YAML::load_file(File.join($root_path, 'config', 'config.yml'))
      end
    end
  end
end
