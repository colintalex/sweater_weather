class CityWeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :current, :hourly, :daily
end
