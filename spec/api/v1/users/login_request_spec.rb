require 'rails_helper'

describe "User Login Request" do
  it "can return the users id and api_key if credentials match" do
    user = User.create({ "email": "whatever@example.com",
                      "password": "password",
         "password_confirmation": "password" })
   user_params = {
                   "email": "whatever@example.com",
                   "password": "password",
                   "password_confirmation": "password"
                 }
    post '/api/v1/sessions', params: user_params

    expect(response).to be_successful
    expect(response.status).to eql(200)

    json = JSON.parse(response.body, symbolize_names:true)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:type]).to eql('users')
    expect(json[:data][:attributes][:email]).to eql(user.email)
    expect(json[:data][:attributes][:api_key]).to_not be_nil
  end
end
