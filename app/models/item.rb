class Item < ApplicationRecord
  belongs_to :user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :item_status
  belongs_to_active_hash :delivery_fee_burden
  belongs_to_active_hash :prefectures
  belongs_to_active_hash :day_to_ship

  with_options presence: true do
    validates :item_name
    validates :item_explanation
    validates :price, numericality: {
      only_integer: true, 
      greater_than_or_equal_to: 300, 
      less_than_or_equal_to: 9999999
    }

    with_options numericality: {other_than: 0, message: "can't be blank"} do
      validates :category_id
      validates :item_status_id
      validates :delivery_fee_burden_id
      validates :prefectures_id
      validates :day_to_ship_id
    end
  end
end
