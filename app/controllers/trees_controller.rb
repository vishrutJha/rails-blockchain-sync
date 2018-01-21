class TreesController < ApplicationController
  def index
    trees = Tree.all
    # trees = trees.where(farmer_id: @user._id)
    trees = trees.where(land_id: params[:land_id])
    render json: trees
  end

  def create
  end

  def update
  end

  protected
    def tree_params
    end
end
