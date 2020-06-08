require 'date'
class CityWeather
  attr_reader :id, :current, :hourly, :daily
    def initialize(data)
      @time_offset = data['timezone_offset']
      @current = current_convert(data)
      @hourly = hourly_convert(data)[0..7]
      @daily = daily_convert(data)[0..4]
    end

    def current_convert(data)
      raw_time = ( data['current']['dt'] + @time_offset )
      data['current']['dt'] = DateTime.strptime(raw_time.to_s, '%s')
      raw_time = ( data['current']['sunrise'] + @time_offset )
      data['current']['sunrise'] = DateTime.strptime(raw_time.to_s, '%s')
      raw_time = ( data['current']['sunset'] + @time_offset )
      data['current']['sunset'] = DateTime.strptime(raw_time.to_s, '%s')
      data['current']
    end

    def hourly_convert(data)
      data['hourly'].each do |hour|
        raw_time = ( data['current']['dt'] + @time_offset )
        hour['dt'] = DateTime.strptime(raw_time.to_s, '%s')
      end
    end

    def daily_convert(data)
      data['daily'].each do |day|
        day['dt'] = DateTime.strptime((day['dt'] + @time_offset).to_s, '%s')
        day['sunrise'] = DateTime.strptime((day['sunrise'] + @time_offset).to_s, '%s')
        day['sunset'] = DateTime.strptime((day['sunset'] + @time_offset).to_s, '%s')
      end
    end
end
