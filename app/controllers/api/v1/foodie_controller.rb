class Api::V1::FoodieController < ApplicationController
  def show
    
  end

  private

  def foodie_params
    params.permit(:start, :end, :search)
  end

  def get_travel_time(data)
    response = GoogleGeoService.new.travel_time(data[:start], data[:end])
  end
end
