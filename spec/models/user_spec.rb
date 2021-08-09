require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー登録できる時' do
    it '全ての項目が正しく入力されていれば登録できる' do
      expect(@user).to be_valid
    end
  end

  context 'ユーザー登録できない時' do
    it 'nicknameが空では登録できない' do
      @user.nickname = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'emailが重複していると登録できない' do
      another_user = FactoryBot.create(:user)
      @user.email = another_user.email
      @user.valid?
      expect(@user.errors.full_messages).to include('Email has already been taken')
    end
    it 'emailに@が含まれていないと登録できない' do
      @user.email = 'hogehoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが半角英数字混合でも6文字以上でないと登録できない' do
      @user.password = 'abc12'
      @user.password_confirmation = 'abc12' 
      @user.valid?
      expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end
    it 'passwordが半角で6文字以上でも英数字混合でないと登録できない' do
      @user.password = 'abcdef'
      @user.password_confirmation = 'abcdef' 
      @user.valid?
      expect(@user.errors.full_messages).to include('Password Password is invalid. Include both letters and numbers')
    end
    it 'passwordが英数字混合で6文字以上でも半角でないと登録できない' do
      @user.password = 'ABC１２３'
      @user.password_confirmation = 'ABC１２３' 
      @user.valid?
      expect(@user.errors.full_messages).to include('Password Password is invalid. Include both letters and numbers')
    end
    it 'passwordとconfirmation_passwordが一致していないと登録できない' do
      @user.password = 'abc123'
      @user.password_confirmation = '123abc' 
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'first_nameが空では登録できない' do
      @user.first_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'first_nameが全角(漢字・ひながな・カタカナ)でないと登録できない' do
      @user.first_name = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name First name is invalid. Input full-width characters')
    end
    it 'family_nameが空では登録できない' do
      @user.family_name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name can't be blank")
    end
    it 'family_nameが全角(漢字・ひながな・カタカナ)でないと登録できない' do
      @user.family_name = 'hoge'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name Last name is invalid. Input full-width characters')
    end
    it 'first_name_readingが空では登録できない' do
      @user.first_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("First name reading can't be blank")
    end
    it 'first_name_readingが全角（カタカナ）でないと登録できない' do
      @user.first_name_reading = 'ほげ'
      @user.valid?
      expect(@user.errors.full_messages).to include('First name reading First name kana is invalid. Input full-width katakana characters')
    end
    it 'family_name_readingが空では登録できない' do
      @user.family_name_reading = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Family name reading can't be blank")
    end
    it 'family_name_readingが全角（カタカナ）でないと登録できない' do
      @user.family_name_reading = 'ほげ'
      @user.valid?
      expect(@user.errors.full_messages).to include('Family name reading Last name kana is invalid. Input full-width katakana characters')
    end
    it 'birth_dateが空では登録できない' do
      @user.birth_date = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birth date can't be blank")
    end
  end

end

# bundle exec rspec spec/models/user_spec.rb 

# binding.pry

# @user.errors.full_messages
 