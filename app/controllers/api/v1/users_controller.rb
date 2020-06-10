class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: UsersSerializer.new(@user), status: :created
    else
      @error = Error.new(@user.errors.full_messages)
      render json: ErrorSerializer.new(@error), status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

end
