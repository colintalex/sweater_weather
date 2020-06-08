class Api::V1::FoodieController < ApplicationController
  def show
    render json: FoodieSerializer.new(foodie_info(foodie_params))
  end

  private

  def foodie_params
    params.permit(:start, :end, :search)
  end

  def foodie_info(data)
    info = get_travel_info(data)
      Foodie.new({travel_time: info['distance']['text'],
                 end_location: data['end'],
                     forecast: get_forecast(info['end_location']),
                   restaurant: get_restaurant(info['end_location']) })
  end

  def get_travel_info(data)
    GoogleGeoService.new.travel_time(data[:start], data[:end])
  end

  def get_forecast(coordinates)
    OpenWeatherService.new.get_forecast(coordinates)
  end

  def get_restaurant(coordinates)
    ZomatoService.new.closest_restaurant(coordinates)
  end
end
