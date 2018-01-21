class OfficersController < ApplicationController
  def index
    @officers = Officer.all
    render json: @officers
  end
end
