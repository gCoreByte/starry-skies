# frozen_string_literal: true

FactoryBot.define do
  factory :page_template do
    store { association(:store) }
    created_by { association(:fingerprint) }
    updated_by { created_by }

    sequence(:key) { |n| "page_template_#{n}" }
    content { 'MyText' }
    status { PageTemplate::Statuses::ACTIVE }
    based_on { 'store' }
  end
end
