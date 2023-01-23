FactoryBot.define do
  factory :category do
    spanish_description { Faker::Lorem.sentence }
    english_description { Faker::Lorem.sentence }
  end
end
