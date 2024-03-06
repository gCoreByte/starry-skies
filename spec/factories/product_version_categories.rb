# frozen_string_literal: true

FactoryBot.define do
  factory :product_version_category do
    transient do
      store { @overrides[:product_version]&.store || @overrides[:product_category]&.store || association(:store) }
    end
    product_version { association(:product_version, store: store) }
    product_category { association(:product_category, store: store) }
    created_by { association(:fingerprint) }
  end
end
