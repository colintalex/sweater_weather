class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      render json: UsersSerializer.new(@user)
    else
      @error = auth_error(@user)
      render json: ErrorSerializer.new(@error), status: :unauthorized
    end
  end

  private

  def auth_error(user)
    if user.nil?
      Error.new(no_user_error)
    else
      Error.new(bad_password_error)
    end
  end

  def bad_password_error
    'Incorrect password, please try again'
  end

  def no_user_error
    'Email is not registered. Please sign-up for access.'
  end
end
