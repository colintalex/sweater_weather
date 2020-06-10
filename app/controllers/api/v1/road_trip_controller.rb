class Api::V1::RoadTripController < ApplicationController
  before_action :authenticate_api_key

  def create
    @trip = RoadTrip.new(trip_params)
    render json: RoadTripSerializer.new(@trip)
  end

  private

  def trip_params
    params.permit(:origin, :destination)
  end

  def authenticate_api_key
    user = User.find_by(api_key: params[:api_key])
    if user.nil?
      render json: ErrorSerializer.new(bad_api_key), status: :unauthorized
    end
  end

  def bad_api_key
    Error.new('Unauthorized access. Sign up for API key, or check your current one')
  end
end
