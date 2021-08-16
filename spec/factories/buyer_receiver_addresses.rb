
FactoryBot.define do  

  factory :buyer_receiver_address do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code { '123-4567' }
    prefectures_id {2}
    city {Faker::Lorem.words(number: 1)}
    house_number {Faker::Lorem.words(number: 1)}
    building_name {Faker::Lorem.words(number: 1)}
    phone_number {Faker::Number.between(from: 1000000000, to: 99999999999)}
  
  end
end
 