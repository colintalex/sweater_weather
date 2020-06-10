require 'rails_helper'

RSpec.describe OpenWeatherService do
  it "exists" do
    service = OpenWeatherService.new

    expect(service).to be_instance_of OpenWeatherService
  end

  it "can return weather data for a latitude and longitude" do
    VCR.use_cassette('latlong_weather') do
      coordinates = { lat: 27.7676008, lng: -82.64029149999999 }
      service = OpenWeatherService.new
      weather_data = service.get_forecast(coordinates)

      expect(weather_data).to have_key(:current)
      expect(weather_data[:current]).to have_key(:temp)
      expect(weather_data[:current]).to have_key(:weather)
      expect(weather_data[:current][:weather].first).to have_key(:description)
      expect(weather_data).to have_key(:hourly)
      expect(weather_data[:hourly].first).to have_key(:temp)
      expect(weather_data[:hourly].first).to have_key(:humidity)
      expect(weather_data[:hourly].first).to have_key(:weather)
      expect(weather_data[:daily].first).to have_key(:rain)
    end
  end
end
