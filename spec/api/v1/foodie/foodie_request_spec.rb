require 'rails_helper'

describe "Food Search Query" do
  it "Can return travel time to a city and a nearby restaurant based on search term" do
    get  '/api/v1/foodie?start=denver,co&end=pueblo,co&search=italian'

    expect(response).to be_successful
    
  end
end
