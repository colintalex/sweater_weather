class Api::V1::FoodieController < ApplicationController
  def show
    foodie_obj = Foodie.new(foodie(foodie_params))
    render json: FoodieSerializer.new(foodie_obj)
  end

  private

  def foodie_params
    params.permit(:start, :end, :search)
  end

  def foodie(data)
    info = get_travel_info(data)
    new_data = {}
    new_data[:travel_time] = info['distance']['text']
    new_data[:end_location] = data[:end]
    new_data[:forecast] = get_forecast(info['end_location'])
    new_data[:restaurant] = get_restaurant(info['end_location'])
    new_data
  end

  def get_travel_info(data)
    response = GoogleGeoService.new.travel_time(data[:start], data[:end])
    json = JSON.parse(response.body, symbolize_headers: true)
    json['routes'].first['legs'].first
  end

  def get_forecast(coordinates)
    json = OpenWeatherService.new.get_forecast(coordinates)
        {summary: json['current']['weather'].first['description'],
     temperature: json['current']['temp']}
  end

  def get_restaurant(coordinates)
    json = ZomatoService.new.closest_restaurant(coordinates)
  end
end
