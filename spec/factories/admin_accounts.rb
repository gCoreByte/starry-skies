# frozen_string_literal: true

FactoryBot.define do
  factory :admin_account do
    name { 'Example' }
    password { 'password' }
    email { Faker::Internet.email }
  end
end
