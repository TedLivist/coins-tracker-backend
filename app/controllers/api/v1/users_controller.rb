class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:auto_login]

  # REGISTER
  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      @errors = @user.errors.full_messages
      render json: {error: @errors}
    end
  end

  # LOGGING IN
  def login
    @user = User.find_by(username: params[:username])

    if @user
      token = encode_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      @error = ['Invalid username']
      render json: {error: @error}
    end
  end


  def auto_login
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
