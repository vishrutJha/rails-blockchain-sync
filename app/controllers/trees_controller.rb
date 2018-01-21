class TreesController < ApplicationController
  def index
    trees = Tree.all
    # trees = trees.where(farmer_id: @user._id)
    # trees = trees.where(land_id: params[:land_id])
    render json: {trees: trees}
  end

  def requests
    trees = Tree.where(status: Tree::STATUSES[:cut_requested])
    render json: {trees: trees}
  end

  def ledger
    tree = Tree.find(params[:id])
    render json: { ledger: tree.all_ledgers }
  end

  def approve
    tree = Tree.find(params[:id])
    if tree.update(status: Tree::STATUSES[:cut_approved])
      render json: { tree: tree }
    else
      render json: { tree: tree, message: "Update Decilined" }
    end
  end

  def create
  end

  def update
  end

  def cut_request
    results = Tree.cut_requests(params[:ids])
    render json: {trees: results}
  end

  protected
    def tree_params
    end
end
