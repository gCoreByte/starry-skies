# frozen_string_literal: true

FactoryBot.define do
  factory :package do
    price { '9.99' }
    name { 'MyString' }
    key { 'MyString' }
    features { 'MyString' }
  end
end
