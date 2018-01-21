class TreesController < ApplicationController
  def index
    trees = Tree.all
    # trees = trees.where(farmer_id: @user._id)
    trees = trees.where(land_id: params[:land_id])
    render json: {trees: trees}
  end

  def create
  end

  def update
  end

  def cut_request
    trees = Tree.where(id: params[:ids])
    render json: {trees: trees}
  end

  protected
    def tree_params
    end
end
