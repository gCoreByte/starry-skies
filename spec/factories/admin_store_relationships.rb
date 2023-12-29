# frozen_string_literal: true

FactoryBot.define do
  factory :admin_store_relationship do
    store { association(:store) }
    admin_account { association(:admin_account) }
    type_key { 'MyString' }
  end
end
