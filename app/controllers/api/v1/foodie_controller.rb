class Api::V1::FoodieController < ApplicationController
  def show
    render json: FoodieSerializer.new(foodie(foodie_params))
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
  end

  def get_travel_info(data)
    response = GoogleGeoService.new.travel_time(data[:start], data[:end])
    json = JSON.parse(response.body, symbolize_headers: true)
    json['routes'].first['legs'].first
  end

  def get_forecast(coordinates)
    response = OpenWeatherService.new.get_forecast(coordinates)
    response['current']['weather'].first['description']
  end
end
