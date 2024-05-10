# frozen_string_literal: true

FactoryBot.define do
  factory :page_translation do
    store { @overrides[:page_template]&.store || association(:store) }
    page_template { association(:page_template) }
    created_by { association(:fingerprint) }
    locale { 'en' }
    content { 'Welcome to {{ store.name }}' }
  end
end
