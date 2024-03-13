# frozen_string_literal: true

FactoryBot.define do
  factory :product_price do
    locale { 'MyString' }
    price { '9.99' }
    currency { 'MyString' }
    deactivated_at { '2023-12-29 12:56:45' }
    store { @overrides[:product_version]&.store || association(:store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
    product_version { association(:product_version, store: store) }
  end
end
