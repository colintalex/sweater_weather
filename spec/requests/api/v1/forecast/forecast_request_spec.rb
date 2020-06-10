require 'rails_helper'

describe "Forecast API Query" do
  it "can return the forecast for a given city and state" do
    get '/api/v1/forecast?location=denver,co'

    expect(response).to be_successful
    forecast_data = JSON.parse(response.body, symbolize_headers: true)
    forecast = forecast_data['data']['attributes']

    expect(forecast['current']).to be_a(Hash)
    expect(forecast['hourly']).to be_a(Array)
    expect(forecast['hourly'].first).to be_a(Hash)
    expect(forecast['hourly']).to be_a(Array)
    expect(forecast['daily'].first).to be_a(Hash)
  end

  it "can return the image of the current city" do
    get '/api/v1/backgrounds?location=vail,co'

    expect(response).to be_successful
  end
end
