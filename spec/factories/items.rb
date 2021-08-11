FactoryBot.define do
  factory :item do
    item_name {Faker::Lorem.words(number: 1)}
    item_explanation {Faker::Lorem.sentence}
    item_status_id {2}
    category_id {2}
    delivery_fee_burden_id {2}
    prefectures_id {2}
    day_to_ship_id {2}
    price {Faker::Number.between(from: 300, to: 9999999)}

    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/forest.jpeg'), filename: 'forest.jpeg')
    end
  end
end
 