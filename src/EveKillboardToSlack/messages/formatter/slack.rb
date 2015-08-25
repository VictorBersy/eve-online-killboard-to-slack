module EveKillboardToSlack
  module Message
    module Formatter
      class SlackFormatter
        def initialize(data)
          @data = data
        end

        def format
          message = {
            link: format_link_message,
            attachment: format_attachment
          }
        end

        private

        def data
          {
            type: @data[:type],
            date: @data[:time].strftime('%Y-%m-%d at %H:%M:%S (EvE Time)'),
            pilot_name: @data[:pilot_name],
            pilot_id: @data[:pilot_id],
            corporation_name: @data[:corporation_name],
            total_value: @data[:isk_value],
            zkillboard_link: @data[:link]
          }
        end

        def get_color_by_type(type)
          colors = {kill: 'good', loss: 'danger'}
          colors[type.to_sym]
        end

        def format_link_message
          "New #{data[:type]} : [#{data[:date]} : "\
          "#{data[:pilot_name]}(#{data[:corporation_name]}) / "\
          "#{data[:total_value]}](#{data[:zkillboard_link]})"
        end

        def format_attachment
          {
            fallback: "New #{data[:type]} #{data[:zkillboard_link]}",
            color: get_color_by_type(data[:type]),
            author_name: data[:pilot_name],
            author_link: data[:pilot_id],
            fields: [
              { title: 'Date', value: data[:date], short: true },
              { title: 'Pilot Name', value: data[:pilot_name], short: true },
              { title: 'Corporation Name', value: data[:corporation_name], short: true },
              { title: 'Total Value', value: data[:total_value], short: true }
            ]
          }
        end
      end
    end
  end
end

