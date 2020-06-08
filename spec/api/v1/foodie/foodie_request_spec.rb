require 'rails_helper'

describe "Food Search Query" do
  it "Can return travel time to a city and a nearby restaurant based on search term" do
    get  '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'

    expect(response).to be_successful
    json = JSON.parse(response.body, symbolize_name:true)

    expect(json['data']).to be_a(Hash)
    expect(json['data']['type']).to eql('foodie')
    expect(json['data']['attributes']).to be_a(Hash)
    expect(json['data']['attributes']['end_location']).to be_a(String)
    expect(json['data']['attributes']['travel_time']).to be_a(String)
    expect(json['data']['attributes']['forecast']).to be_a(Hash)
    expect(json['data']['attributes']['restaurant']).to be_a(Hash)

  end
end
