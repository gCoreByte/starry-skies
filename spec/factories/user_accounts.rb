# frozen_string_literal: true

FactoryBot.define do
  factory :user_account do
    email { Faker::Internet.email }
    password { 'password' }
    store { association(:store) }
  end
end
