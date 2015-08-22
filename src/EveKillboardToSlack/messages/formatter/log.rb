module EveKillboardToSlack
  module Message
    module Formatter
      class LogFormatter
        def initialize(data)
          @data = data
        end

        def format
          { raw: raw_message, colored: colored_message }
        end

        private

        def raw_message
          type = @data[:type]
          date = @data[:time].strftime('%Y-%m-%d at %H:%M:%S (EvE Time)')
          pilot_name = @data[:pilot_name]
          corporation_name = @data[:corporation_name]
          total_value = @data[:isk_value]
          zkillboard_link = @data[:link]

          "New #{type} : [#{date} : #{pilot_name}(#{corporation_name}) "\
          "/ #{total_value}](#{zkillboard_link})"
        end

        def colored_message
          type = Rainbow("New #{@data[:type]}").red
          date = @data[:time].strftime('%Y-%m-%d at %H:%M:%S (EvE Time)')
          date = Rainbow(date).yellow
          pilot_name = Rainbow(@data[:pilot_name]).blue
          corporation_name = Rainbow(@data[:corporation_name]).blue
          total_value = Rainbow(@data[:isk_value]).green
          zkillboard_link = @data[:link]

          "#{type} at #{date} : #{pilot_name}(#{corporation_name}) / "\
          "#{total_value} #{zkillboard_link}"
        end
      end
    end
  end
end
