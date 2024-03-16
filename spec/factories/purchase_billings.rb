# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_billing do
    store { @overrides[:purchase_order]&.store || association(:store) }
    purchase_order { association(:purchase_order, store: store) }
    created_by { association(:fingerprint) }
    first_name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone }
  end
end
