class BuyerReceiverAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :prefectures_id, :city, :house_number, :building_name, :phone_number, :buyer_id, :token

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :prefectures_id
    validates :city
    validates :house_number
    validates :postal_code, format: {with: /\A\d{3}[-]\d{4}\z/ ,message:"is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :phone_number, length: {in: 10..11, message:"Phone number is too short"}
    validates :phone_number, format: {with: /\A[0-9]+\z/,message:"Phone number is invalid. Input only number"} 
  end


  def save
    buyer = Buyer.create(user_id: user_id,item_id: item_id)
    ReceiverAddress.create(
      postal_code: postal_code, prefectures_id: prefectures_id, city: city, house_number: house_number, 
      building_name: building_name, phone_number: phone_number, buyer_id: buyer.id
     )
  end
end