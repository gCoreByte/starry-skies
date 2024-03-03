# frozen_string_literal: true

FactoryBot.define do
  factory :admin_store_permission do
    type_key { 'product.create' }
    store { association(:store) }
    admin_account { association(:admin_account) }
    created_by { association(:fingerprint) }
  end
end
