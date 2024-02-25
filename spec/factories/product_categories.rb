# frozen_string_literal: true

FactoryBot.define do
  factory :product_category do
    name { 'test' }
    key { 'test' }
    created_by { association(:fingerprint) }
    updated_by { created_by }
  end
end
