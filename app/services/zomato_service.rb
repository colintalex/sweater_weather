class ZomatoService
  def closest_restaurant(coordinates, keyword)
    response = conn.get('api/v2.1/search') do |req|
      req.params[:q] = keyword
      req.params[:lat] = coordinates['lat']
      req.params[:lon] = coordinates['lng']
    end
    extract_info(response)
  end

  private

  def conn
    Faraday.new('https://developers.zomato.com') do |f|
      f.headers['user-key'] = ENV['ZOMATO_API_KEY']
    end
  end

  def extract_info(response)
    json = JSON.parse(response.body, symbolize_headers:true)
    restaurant = json['restaurants'].first['restaurant']
      {name: restaurant['name'],
    address: restaurant['location']['address']}
  end
end
