FactoryBot.define do
  factory :product do
    spanish_description { "MyText" }
    english_description { "MyText" }
    unit { 1 }
    price_mxn { "9.99" }
    concept { nil }
  end
end
