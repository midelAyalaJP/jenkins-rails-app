FactoryBot.define do
  factory :concept do
    spanish_description { Faker::Lorem.sentence }
    english_description { Faker::Lorem.sentence }
    category
  end
end
