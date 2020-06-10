require 'rails_helper'

describe "Road Trip Request" do
    it "can receive an road trip request w/ API key and return travel_time and forecast" do
      user = User.create({ "email": "whatever@example.com",
                        "password": "password",
           "password_confirmation": "password" })
      trip_params = { origin: "Denver,CO",
            destination: "Santa Fe,NM",
                api_key: user.api_key}

      post '/api/v1/road_trip', params: trip_params

      expect(response).to be_successful
      expect(response.status).to eql(200)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data]).to have_key(:type)
      expect(json[:data]).to have_key(:attributes)
      expect(json[:data][:type]).to eql('road_trip')
      expect(json[:data][:attributes]).to have_key(:travel_time)
      expect(json[:data][:attributes]).to have_key(:arrival_forecast)
      expect(json[:data][:attributes][:arrival_forecast]).to have_key(:temp)
      expect(json[:data][:attributes][:arrival_forecast]).to have_key(:summary)
    end

    it "can return an error message and error status if api_key is not valid" do
      trip_params = { origin: "Denver,CO",
            destination: "Santa Fe,NM",
                api_key: "Som3RanD0mK3Y"}

      error_msg = 'Unauthorized access. Sign up for API key, or check your current one'

      post '/api/v1/road_trip', params: trip_params

      expect(response.status).to eql(401)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(json[:data][:type]).to eql('error')
      expect(json[:data][:attributes][:description]).to eql(error_msg)
    end
end
