# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_order do
    store { @overrides[:purchase_cart]&.store || association(:store) }
    purchase_cart { association(:purchase_cart, store: store) }
    first_name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    phone_number { Faker::PhoneNumber.cell_phone }

    created

    PurchaseOrder::Statuses::ALL.each do |status|
      trait status.to_sym do
        status { status }
      end
    end
  end
end
