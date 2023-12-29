# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    name { 'cool store' }
    url { 'https://www.example.com' }
    key { 'cool_store' }
  end
end
