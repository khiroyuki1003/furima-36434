class ItemsController < ApplicationController
  before_action :redirect_to_index, only: :new 

  def index
    @item = Item.includes(:user).order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private
  def redirect_to_index
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def item_params
    params.require(:item).permit(
      :image, :item_name, :item_explanation, :item_status_id, :category_id,
       :delivery_fee_burden_id, :prefectures_id, :day_to_ship_id, :price 
      ).merge(user_id: current_user.id)
  end
end
