class LandsController < ApplicationController
  def index
    lands = Land.all
    render json: {lands: lands}
  end

  def show
    land = Land.where(id: params[:id])
    render json: { land: land }
  end

  def create
    land = Land.new(land_params)
    land.user = @user
    if land.save
      render json: { land: land, message: "Saved Successfully" }
    else
      render json: { land: land, message: "Error Saving" }
    end
  end

  def update
    land = Land.new(land_params)
    land.user = @user
    if land.save
      render json: { land: land, message: "Saved Successfully" }
    else
      render json: { land: land, message: "Error Saving" }
    end
  end

  protected
    def land_params
      params.require(:land).permit(:size, :allocation, :liability, :latitude, :longitude, :user_type)
    end
end
