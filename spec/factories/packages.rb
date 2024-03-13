# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    price { '9.99' }
    name { 'MyString' }
    key { Faker::Alphanumeric.alpha(number: 10) }
    features { [Features::BASE] }
  end
end
