# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'MyString' }
    key { 'test_string' }
    store { association(:store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
  end
end
