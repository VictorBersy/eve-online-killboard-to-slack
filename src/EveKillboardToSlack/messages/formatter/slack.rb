module EveKillboardToSlack
  module Message
    module Formatter
      class SlackFormatter
        def initialize(data)
          @data = data
        end

        def format
          type = @data[:type]
          date = @data[:time].strftime('%Y-%m-%d at %H:%M:%S (EvE Time)')
          pilot_name = @data[:pilot_name]
          total_value = @data[:isk_value]
          zkillboard_link = @data[:link]

          "New #{type} : [#{date} : #{pilot_name} / #{total_value}](#{zkillboard_link})"
        end
      end
    end
  end
end
