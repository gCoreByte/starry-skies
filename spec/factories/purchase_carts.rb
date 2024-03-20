# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_cart do
    store { association(:store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
    expires_at { 6.hours.from_now }
    status { PurchaseCart::Statuses::CREATED }

    PurchaseCart::Statuses::ALL.each do |status|
      trait status.to_sym do
        status { status }
      end
    end
  end
end
