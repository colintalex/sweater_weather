class Foodie
  attr_reader :id, :end_location, :travel_time, :forecast, :restaurant
  def initialize(data)
    @end_location = data[:end_location]
    @travel_time = data[:travel_time]
    @forecast = data[:forecast]
    @restaurant = data[:restaurant]
  end
end
