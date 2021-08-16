class BuyersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :buy_access_check, only: [:index, :create]

  def index
    @buyer_receiver_address = BuyerReceiverAddress.new
  end
 
  def create
    @buyer_receiver_address = BuyerReceiverAddress.new(buyer_params)
    
    if @buyer_receiver_address.valid?
      pay_item
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

  def buy_access_check
    if  @item.buyer.present? || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def buyer_params
    params.require(:buyer_receiver_address).permit(
      :postal_code, :prefectures_id, :city, :house_number, :building_name, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token]) 
  end

  ##Payjpを利用した決済処理
  def pay_item
    # Gem「payjp」のPayjpクラスのapi_keyインスタンスに秘密鍵を代入
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    # Gemのクラスとメソッドで、決済に必要な情報を記述する
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: buyer_params[:token],   #token
      currency: 'jpy'              #通過の種類
    )
  end
end
  