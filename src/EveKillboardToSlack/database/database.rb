module EveKillboardToSlack
  class Database
    def initialize
    end

    def set(name, value)
      write(name, value)
    end

    def get(name)
      read[name.to_sym].to_s
    end

    private

    def read
      YAML::load_file(File.join($root_path, 'config', 'database.yml'))
    end

    def write(name, value)
      data = read
      data[name.to_sym] = value
      file_path = File.join($root_path, 'config', 'database.yml')
      File.open(file_path, 'w') { |f| f.write data.to_yaml }
    end
  end
end
