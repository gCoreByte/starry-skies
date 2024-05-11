# frozen_string_literal: true

FactoryBot.define do
  factory :blog_post_translation do
    store { @overrides[:blog_post]&.store || association(:store) }
    blog_post { association(:blog_post) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
    locale { 'en' }
    content { '### hi' }
  end
end
