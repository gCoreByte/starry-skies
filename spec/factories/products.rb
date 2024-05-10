# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    store { association(:store) }
    key { "product-#{SecureRandom.hex}" }
    created_by { association(:fingerprint) }
    updated_by { created_by }
  end
end
