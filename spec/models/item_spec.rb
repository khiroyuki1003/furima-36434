require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  context '商品出品できる時' do
    it '全ての項目が正しく入力されていれば出品できる' do
      expect(@item).to be_valid
    end
  end

  context '商品出品できない時' do
    it 'imageが選択されていないと保存できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'item_nameが空だと保存できない' do
      @item.item_name = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Item name can't be blank")
    end
    it 'item_explanationが空だと保存できない' do
      @item.item_explanation = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Item explanation can't be blank")
    end

    # 価格が全角数字では保存できない（現在記述頂いている内容かと存じます。）
    # 価格が半角英数字混合では保存できない
    # 価格が半角英字だけでは保存できない

    it 'priceが空だと保存できない' do
      @item.price = ""
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが全角数字では保存できない' do
      @item.price = "１２３４５６"
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
    end
    it 'priceが半角英数字混合では保存できない' do
      @item.price = "abc123"
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
    end
    it 'priceが半角英字だけでは保存できない' do
      @item.price = "abcdef"
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is invalid. Input half-width characters')
    end
    it 'priceが半角でも¥300より小さいと保存できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is out of setting range')
    end
    it 'priceが半角でも¥9,999,999より大きいと保存できない' do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is out of setting range')
    end

    it 'カテゴリーの選択が「---」だと保存できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it '商品の状態の選択が「---」だと保存できない' do
      @item.item_status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Item status can't be blank")
    end
    it '配送料負担の選択が「---」だと保存できない' do
      @item.delivery_fee_burden_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery fee burden can't be blank")
    end
    it '発送元の都道府県の選択が「---」だと保存できない' do
      @item.prefectures_id= 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefectures can't be blank")
    end
    it '発送までの日数の選択が「---」だと保存できない' do
      @item.day_to_ship_id= 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Day to ship can't be blank")
    end
  end
end
 
# bundle exec rspec spec/models/item_spec.rb 

# binding.pry

# @item.errors.full_messages