# frozen_string_literal: true

FactoryBot.define do
  factory :store do
    name { 'cool store' }
    url { 'https://www.example.com' }
    created_by { association(:fingerprint) }
    updated_by { created_by }
  end
end
