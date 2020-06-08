class OpenWeatherService

  def get_forecast(coordinates)
    response = conn.get('data/2.5/onecall?') do |req|
      req.params[:lat] = coordinates['lat']
      req.params[:lon] = coordinates['lng']
      req.params[:exclude] = 'minutely'
      req.params[:units] = 'imperial'
    end
    json = JSON.parse(response.body, symbpolize_headers: true)
  end

  private

  def conn
    Faraday.new('https://api.openweathermap.org') do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    end
  end
end
