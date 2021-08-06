# テーブル設計

## Users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false |
| encrypted_password | string | null: false |
| name               | string | null: false |
| first_name         | string | null: false, format: {with: /\A[ぁ-んァ-ン一-龥]/ } |
| family_name        | string | null: false, format: {with: /\A[ぁ-んァ-ン一-龥]/ } |
| first_name_reading | string | null: false, format: {with: /\A[ァ-ヶー－]+\z/ } |
| family_name_reading | string | null: false, format: {with: /\A[ァ-ヶー－]+\z/ } |
| birth_date         | string | null: false |

### Association

- has_many :items


## Items テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| item_name           | string | null: false |
| item_explanation    | text | null: false |
| category            | integer | null: false, numericality: {other_than: 0} |
| delivery_fee_burden | integer | null: false, numericality: {other_than: 0} |
| prefectures         | integer | null: false, numericality: {other_than: 0} |
| day_to_ship         | integer | null: false, numericality: {other_than: 0} |
| price               | integer | null: false, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, }|
| user                | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :receiver_address


##  ReceiverAddressテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| postal_code   | string | null: false, format: {with: /\A\d{3}[-]\d{4}\z/ } |
| prefectures   | integer | null: false, numericality: {other_than: 0} |
| city          | string | null: false |
| house_number  | string | null: false, numericality: {other_than: 0} |
| building_name | integer |  |
| item          | references | null: false, foreign_key: true |


### Association

- belongs_to :item
- has_one :buyer_number


##  BuyerNumberテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| phone_number       | integer | null: false, format: {with: /\A\d{10,11}\z/} | 
| receiver_address   | references | null: false, foreign_key: true |


### Association

- belongs_to :receiver_address
