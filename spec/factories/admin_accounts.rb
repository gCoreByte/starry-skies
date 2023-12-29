# frozen_string_literal: true

FactoryBot.define do
  factory :admin_account do
    password { 'password' }
    display_name { 'admin' }
    name { 'admin' }
    email { 'example@example.org' }
  end
end
