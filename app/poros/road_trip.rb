class RoadTrip
  attr_reader :origin,
             :destination,
             :travel_time,
             :arrival_forecast
  def initialize(data)
    @origin = data[:origin]
    @destination = data[:destination]
    @travel_time = get_travel_time
    @arrival_forecast = get_forecast
  end

  def get_travel_time
    route_info[:duration]
  end

  def get_forecast
    weather = OpenWeatherService.new.get_forecast(route_info[:end_location])
    hours = (@travel_time[:value] / 3600.00).round(0)
    weather[:hourly][hours - 1]
  end

  def route_info
    route ||= GoogleGeoService.new.get_directions(@origin, @destination)
    route[:routes][0][:legs][0]
  end
end
