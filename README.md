# Sweater Weather - Built by Colin Alexander
### Versions
Ruby - 2.5.3
Rails - 5.2.4

### Description
Sweater Weather is a Rails based API service, aggregating other public API information. It provides information to an conceptual front end team across many endpoints. It allows a user insight into weather, travel and geographical data combined.

### Running on Local Machine
- `https://github.com/coloniusrex/sweater_weather.git`
- run `bundle install`,

### Heroku URL for API
https://sweater-weather-api-cta.herokuapp.com/

### Endpoints
- __/api/v1/forecast?location=_city_,_state___
  - returns weather information for the location

- __/api/v1/backgrounds?location=_city_,_state___
  - returns an appropriate image from Unsplash based on location

- __/api/v1/users__
  - pass json in body of request:  
  ```
  { email: _user@example_,
    password: _value_,
    password_confirmation: _value_ }
  ```
  - creates users and returns information including email and api-key
- __/api/v1/sessions (returns api-key)__
  - pass json in body of request:  
  ```
  { email: _user@example_,
    password: _value_ }
  ```
  - returns api-key of user

- __/api/v1/road_trip__
  - pass json in body of request:  
  ```
  { origin: _city,state_,
    destination: _city,state_,
    api-key: _valid api-key_ }
  ```
  - returns travel time and forecast of destination upon arrival.

### Specs
- Testing with RSpec
- `bundle exec rspec` to run all tests
- `bundle exec rspec _filepath_` to run individual specs

### Services / API
- Google API:
  - Directions
  - Geocode
  - Places
- OpenWeather API
  - OneCall

### Database
  - PostgreSQL
  - `rails db:{create,migrate}` for setup
  
  ![TeamImage](https://github.com/coloniusrex/sweater_weather/blob/master/team_index.png)
