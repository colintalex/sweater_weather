class Api::V1::ForecastController < ApplicationController

  def show
    coordinates = get_coordinates(forecast_params[:location])
    @weather = get_weather(coordinates)
    render json: CityWeatherSerializer.new(@weather)
  end

  private

  def forecast_params
    params.permit(:location)
  end

  def get_coordinates(location)
    GoogleGeoService.new.get_coords(location)
  end

  def get_weather(coordinates)
    json = OpenWeatherService.new.get_forecast(coordinates)
    CityWeather.new(json)
  end
end
