require 'rails_helper'

RSpec.describe BuyerReceiverAddress, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @buyer_receiver_address = FactoryBot.build(:buyer_receiver_address, user_id: user.id, item_id: item.id)
  end

  describe '商品購入機能' do 
    context '商品購入できる時' do
      it '全ての項目が正しく入力されていれば購入できる' do
        expect(@buyer_receiver_address).to be_valid
      end
      it 'building_nameが空でも購入できる' do
        @buyer_receiver_address.building_name = ""
        expect(@buyer_receiver_address).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'user_idが空では購入できない' do
        @buyer_receiver_address.user_id = nil
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("User can't be blank")
      end
      it 'item_idが空では購入できない' do
        @buyer_receiver_address.item_id = nil
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("Item can't be blank")
      end
      it 'tokenが無いと購入できない' do
        @buyer_receiver_address.token = ""
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("Token can't be blank")
      end
      it 'prefectures_idが選択されていないと購入できない' do
        @buyer_receiver_address.prefectures_id = "1"
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("Prefectures can't be blank")
      end
      it 'cityが空だと購入できない' do
        @buyer_receiver_address.city = ""
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("City can't be blank")
      end
      it 'house_numberが空だと購入できない' do
        @buyer_receiver_address.house_number = ""
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("House number can't be blank")
      end
    
      it 'postal_codeが空だと購入できない' do
        @buyer_receiver_address.postal_code = ""
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("Postal code can't be blank")
      end
      it 'postal_codeが全角だと購入できない' do
        @buyer_receiver_address.postal_code = "１２３−４５６７"
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it 'postal_codeは「-」が無いと購入できない' do
        @buyer_receiver_address.postal_code = 1234567
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
    
      it 'phone_numberが空だと登録できない' do
        @buyer_receiver_address.phone_number = ""
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下だと登録できない' do
        @buyer_receiver_address.phone_number = 123456789
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include('Phone number is too short')
      end
      it 'phone_numberが12桁以上だと登録できない' do
        @buyer_receiver_address.phone_number = 123456789012
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include('Phone number is too short')
      end
      it 'phone_numberが全角だと登録できない' do
        @buyer_receiver_address.phone_number = "１２３４５６７８９０"
        @buyer_receiver_address.valid?
        expect(@buyer_receiver_address.errors.full_messages ).to include('Phone number is invalid. Input only number')
      end
    end
  end
end

# bundle exec rspec spec/models/buyer_receiver_address_spec.rb 

# binding.pry

# @buyer_receiver_address.errors.full_messages 