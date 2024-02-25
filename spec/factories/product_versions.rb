# frozen_string_literal: true

FactoryBot.define do
  factory :product_version do
    store { association(:store) }
    product { association(:product, store: store) }
    version { product.product_versions.count + 1 }
    created_by { association(:fingerprint) }
    updated_by { created_by }
  end
end
