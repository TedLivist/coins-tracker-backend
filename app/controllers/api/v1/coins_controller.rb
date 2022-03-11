class Api::V1::CoinsController < ApplicationController
  before_action :authorized

  def index
    @coins = Coin.where(user: @user)
    render json: @coins
  end

  def create
    @coin = Coin.new(coin_params)
    @coin.user = @user

    if @coin.save
      render json: @coin, status: :created
    else
      render json: @coin.errors, status: :unprocessable_entity
    end
  end

  def show
    @coin = Coin.find(params[:id])
    render json: @coin
  end

  def update
    @coin = Coin.find(params[:id])

    if @user == @coin.user
      if @coin.update(coin_params)
        render json: @coin
      else
        render json: @coin.errors, status: :unprocessable_entity
      end
    else
      render json: {error: 'Unauthorized user'}
    end

    
  end

  def destroy
    @coin = Coin.find(params[:id])

    if @user == @coin.user
      @coin.destroy
    else
      render json: {error: 'Unauthorized action'}
    end
  end


  private

  def coin_params
    params.require(:coin).permit(:coin_id, :quantity, :user_id)
  end

end