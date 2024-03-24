# frozen_string_literal: true

class PageTemplateChange < ApplicationRecord
  belongs_to :page_template
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'

  validates :content, :status, presence: true
  validates :status, inclusion: { in: PageTemplate::Statuses::ALL }, allow_nil: true
  validates :content, length: { maximum: 100_000 }, allow_nil: true
end
