FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    email {Faker::Internet.free_email}
    password =  Faker::Lorem.characters(number: 6, min_alpha: 1, min_numeric: 1) 
    password {password}
    password_confirmation {password}
    nickname {Faker::Name.name}
    first_name {Faker::Japanese::Name.first_name}
    family_name {Faker::Japanese::Name.last_name}
    first_name_reading {person.first.katakana}
    family_name_reading {person.last.katakana}
    birth_date {Faker::Date.between(from: '1921-1-1', to: '2021-8-9')}
  end
end
 