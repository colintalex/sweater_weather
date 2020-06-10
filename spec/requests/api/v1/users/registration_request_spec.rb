require 'rails_helper'

describe 'User Registration Request' do
  it "can return a successful response with the users email and unique API key" do
    user_params = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
    post '/api/v1/users', params: user_params

    expect(response).to be_successful
    expect(response.status).to eql(201)

    json = JSON.parse(response.body, symbolize_names:true)

    expect(json[:data]).to be_a(Hash)
    expect(json[:data]).to have_key(:id)
    expect(json[:data]).to have_key(:type)
    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:type]).to eql('users')
    expect(json[:data][:attributes]).to be_a(Hash)
    expect(json[:data][:attributes][:email]).to eql(user_params[:email])
    expect(json[:data][:attributes][:api_key]).to_not be_nil
  end

  it "can send back error if email is already taken" do
    user = User.create({ "email": "whatever@example.com",
                      "password": "password",
         "password_confirmation": "password" })
    user_params = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "password"
                  }
    post '/api/v1/users', params: user_params

    expect(response.status).to eql(422)

    json = JSON.parse(response.body, symbolize_names:true)
    expect(json[:data][:type]).to eql('error')
    expect(json[:data][:attributes][:description]).to eql('Email has already been taken')
  end

  it "can send back error if passwords don't match" do
    user_params = {
                    "email": "whatever@example.com",
                    "password": "password",
                    "password_confirmation": "pASSwordd"
                  }
    post '/api/v1/users', params: user_params

    expect(response.status).to eql(422)

    json = JSON.parse(response.body, symbolize_names:true)
    expect(json[:data][:type]).to eql('error')
    expect(json[:data][:attributes][:description]).to eql("Password confirmation doesn't match Password")
  end

  it "can send back error if an empty field is submitted" do
    user_params = {
                    "email": "",
                    "password": "password",
                    "password_confirmation": "password"
                  }
    post '/api/v1/users', params: user_params

    expect(response.status).to eql(422)

    json = JSON.parse(response.body, symbolize_names:true)
    expect(json[:data][:type]).to eql('error')
    expect(json[:data][:attributes][:description]).to eql("Email can't be blank")
  end

  it "can handle multiple errors with empty field and incorrect passwords" do
    user_params = {
                    "email": "",
                    "password": "password",
                    "password_confirmation": "passrd"
                  }
    post '/api/v1/users', params: user_params

    expect(response.status).to eql(422)

    json = JSON.parse(response.body, symbolize_names:true)
    expect(json[:data][:type]).to eql('error')
    expect(json[:data][:attributes][:description]).to eql("Email can't be blank and Password confirmation doesn't match Password")
  end
end
