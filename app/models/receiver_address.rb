class ReceiverAddress < ApplicationRecord
  belongs_to :buyer
  belongs_to_active_hash :prefectures
end
 