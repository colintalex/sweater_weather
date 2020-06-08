class Api::V1::ImagesController < ApplicationController
  def show
    render json: get_photo(params[:location])
  end

  private

  def get_photo(location)
    GoogleGeoService.new.get_image(location)
  end
end
