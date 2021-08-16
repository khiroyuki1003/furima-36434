# テーブル設計

## Users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| name               | string | null: false |
| first_name         | string | null: false |
| family_name        | string | null: false |
| first_name_reading | string | null: false |
| family_name_reading | string | null: false |
| birth_date         | date | null: false |

### Association

- has_many :items
- has_one :buyer


## Items テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| item_name           | string | null: false |
| item_explanation    | text | null: false |
| item_status_id      | integer | null: false |
| category_id            | integer | null: false |
| delivery_fee_burden_id | integer | null: false |
| prefectures_id         | integer | null: false |
| day_to_ship_id         | integer | null: false |
| price               | integer | null: false |
| user                | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_one :buyer


##  ReceiverAddressesテーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| postal_code   | string | null: false |
| prefectures_id    | integer | null: false |
| city          | string | null: false |
| house_number  | string | null: false |
| building_name | string |  |
| phone_number  | string | null: false |
| buyer          | references | null: false, foreign_key: true |


### Association

- belongs_to :buyer


##  Buyers
テーブル

| Column | Type   | Options     |
| ------ | ------ | ----------- |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :receiver_address
