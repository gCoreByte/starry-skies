# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { 'MyString' }
    store { nil }
    created_by { nil }
  end
end
