# frozen_string_literal: true

FactoryBot.define do
  factory :blog_post do
    store { association(:store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
    sequence(:key) { |n| "blog-post-#{n}" }
  end
end
