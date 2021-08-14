class BuyersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  def index
    @buyer_receiver_address = BuyerReceiverAddress.new
  end

  def create
    @buyer_receiver_address = BuyerReceiverAddress.new(buyer_params)
    
    if @buyer_receiver_address.valid?
      @buyer_receiver_address.save
      redirect_to root_path
    else
      render :index
    end
  end


  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def buyer_params
    params.require(:buyer_receiver_address).permit(
      :postal_code, :prefectures_id, :city, :house_number, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id) 
  end
end
 