class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 入力必須のバリデーション
  with_options presence: true do
    validates :nickname
    validates :birth_date

    # 全角（漢字・ひらがな・カタカナ）のバリデーション
    validates :first_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message:"First name is invalid. Input full-width characters"} 
    validates :family_name, format: {with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message:"Last name is invalid. Input full-width characters"} 

    # 全角（カタカナ）のバリデーション
    validates :first_name_reading, format: {with: /\A[ァ-ヶー]+\z/, message:"First name kana is invalid. Input full-width katakana characters"}
    validates :family_name_reading, format: {with: /\A[ァ-ヶー]+\z/, message:"Last name kana is invalid. Input full-width katakana characters"}
  end

  # 英数字混合必須のバリデーション（英字かつ数字）
  validates :password, format: {with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message:"Password is invalid. Include both letters and numbers"}
end 
