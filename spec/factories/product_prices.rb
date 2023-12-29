# frozen_string_literal: true

FactoryBot.define do
  factory :product_price do
    locale { 'MyString' }
    price { '9.99' }
    currency { 'MyString' }
    deactivated_at { '2023-12-29 12:56:45' }
    store { nil }
    created_by { nil }
    product_version { nil }
  end
end
