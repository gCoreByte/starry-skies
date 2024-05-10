# frozen_string_literal: true

FactoryBot.define do
  factory :product_version do
    store { @overrides[:product]&.store || association(:store) }
    product { association(:product, store: store) }
    version { product.product_versions.count + 1 }
    created_by { association(:fingerprint) }
    updated_by { created_by }

    translations do
      {
        'en' => { 'name' => 'translated english', 'description' => '1' },
        'et' => { 'name' => 'translated estonian' }
      }
    end

    trait :active do
      activated_at { Time.zone.now }
      activated_by { created_by }
    end
  end
end
