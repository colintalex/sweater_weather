require 'rails_helper'

describe "Food Search Query" do
  it "Can return travel time to a city and a nearby restaurant based on search term" do
    get  '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'

    expect(response).to be_successful
    require "pry"; binding.pry
    json = JSON.parse(response.body, symbolize_headers: true)
    expect(json[:data]).to be_a(Hash)
    expect(json[:data][:type]).to eql('foodie')

  end
end
