class ZomatoService
  def closest_restaurant(coordinates)
    response = conn.get('api/v2.1/geocode') do |req|
      req.params[:lat] = coordinates['lat']
      req.params[:lon] = coordinates['lng']
    end
    json = JSON.parse(response.body, symbolize_headers:true)
    restaurant = json['nearby_restaurants'].first['restaurant']
    {name: restaurant['name'],
      address: restaurant['location']['address']}
  end

  private

  def conn
    Faraday.new('https://developers.zomato.com') do |f|
      f.headers['user-key'] = ENV['ZOMATO_API_KEY']
    end
  end
end
