module EveKillboardToSlack
  class Tools
    class << self
      def root_path
        @root_path ||= File.expand_path(File.join(__dir__, '..', '..', '..'))
      end

      def database
        @database ||= EveKillboardToSlack::Database.new
      end

      def config
        @config ||= YAML.load_file(File.join(self.root_path, 'config', 'config.yml'))
      end

      def logger
        @logger ||= Logger.new(File.join(self.root_path, 'logs', 'log.txt'))
      end
    end
  end
end
