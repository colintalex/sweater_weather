class GoogleGeoService
  def get_coords(location)
    json = get_json(location)
    json['results'].first['geometry']['location']
  end

  def get_image(location)
    json = get_photo_reference(location)
    photo_ref = json['candidates'][0]['photos'][0]['photo_reference']
    get_photo_url(photo_ref)
  end

  private

  def conn
    Faraday.new('https://maps.googleapis.com') do |f|
      f.params[:key] = ENV['GOOGLE_GEO_API_KEY']
    end
  end

  def get_json(location)
    response = conn.get('maps/api/geocode/json?') do |req|
      req.params[:address] = location
    end
    JSON.parse(response.body, symbolize_headers: true)
  end

  def get_photo_reference(location)
    response = conn.get('maps/api/place/findplacefromtext/json') do |req|
      req.params[:input] = location
      req.params[:inputtype] = 'textquery'
      req.params[:fields] = 'photos'
    end
    JSON.parse(response.body, symbolize_headers: true)
  end

  def get_photo_url(ref)
    response = conn.get('maps/api/place/photo') do |req|
      req.params[:photoreference] = ref
      req.params[:maxheight] = '400'
    end
    response.headers['location']
  end
end
