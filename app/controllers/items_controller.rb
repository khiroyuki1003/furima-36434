class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :redirect_to_index, only: :new 
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :user_item_check, only: [:edit, :update, :destroy]
 
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
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
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

  def set_item
    @item = Item.find(params[:id])
  end

  def user_item_check
    if @item.user != current_user || @item.buyer.present?
      redirect_to root_path
    end
  end
end
