# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    store { @overrides[:page_template]&.store || association(:store) }
    page_template { association(:page_template, store: store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }
    status { Page::Statuses::DRAFT }
    sequence(:key) { |n| "key-#{n}" }
    url { key }
  end
end
