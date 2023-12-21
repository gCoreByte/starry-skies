# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'smile@example.com' }
    store { association(:store) }
  end
end
