class API::V1::CoinsController < ApplicationController
  before_action :authorized

  def index
    
  end

  def create
    @coin = Coin.new(coin_params)
    @coin.user = @user.id

    if @coin.save
      render json: @coin, status: :created, location: @coin
    else
      render json: @coin.errors, status: :unprocessable_entity
    end
  end

  def update
    @coin = Coin.find(params[:id])

    if @coin.update(coin_params)
      render json: @coin
    else
      render json: @coin.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @coin = Coin.find(params[:id])
    @coin.destroy
  end


  private

  def coin_params
    params.require(:coin).permit(:coin_id, :quantity, :user_id)
  end

end