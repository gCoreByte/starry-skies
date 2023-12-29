# frozen_string_literal: true

FactoryBot.define do
  factory :admin_store_permission do
    type_key { 'MyString' }
    store { association(:store) }
    admin_account { association(:admin_account) }
  end
end