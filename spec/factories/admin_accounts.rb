# frozen_string_literal: true

FactoryBot.define do
  factory :admin_account do
    password { 'password' }
    email { 'example@example.org' }
  end
end
