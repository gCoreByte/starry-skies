# frozen_string_literal: true

FactoryBot.define do
  factory :product_category do
    name { "#{Faker::Commerce.brand}-#{SecureRandom.hex}" }
    key { name }
    store { association(:store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
  end
end
