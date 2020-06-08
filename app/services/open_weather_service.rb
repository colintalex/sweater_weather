class OpenWeatherService

  def get_forecast(coordinates)
    response = forecast_by_coords(coordinates)
    json = JSON.parse(response.body, symbpolize_headers: true)
        {summary: json['current']['weather'].first['description'],
     temperature: json['current']['temp']}
  end

  private

  def conn
    Faraday.new('https://api.openweathermap.org') do |f|
      f.params[:appid] = ENV['OPEN_WEATHER_API_KEY']
    end
  end

  def forecast_by_coords(coordinates)
    conn.get('data/2.5/onecall?') do |req|
      req.params[:lat] = coordinates['lat']
      req.params[:lon] = coordinates['lng']
      req.params[:exclude] = 'minutely'
      req.params[:units] = 'imperial'
    end
  end
end
