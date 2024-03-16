# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    store { @overrides[:record]&.store || association(:store) }
    record { association(:purchase_order, store: store) }
    created_by { association(:fingerprint) }
    address { Faker::Address.full_address }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    postal_code { Faker::Address.zip_code }
  end
end
