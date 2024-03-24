# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'MyString' }
    sequence(:key) { |n| "product_#{n}" }
    store { association(:store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
  end
end
