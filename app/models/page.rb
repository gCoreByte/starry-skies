# frozen_string_literal: true

class Page < ApplicationRecord
  module Statuses
    DRAFT = 'draft'
    LIVE = 'live'
    ALL = [DRAFT, LIVE].freeze
  end

  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  belongs_to :record, polymorphic: true, optional: true
  belongs_to :page_template

  validates :status, :key, :url, presence: true
  validates :status, inclusion: { in: Statuses::ALL }, allow_nil: true
  validates :key, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :url, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :dynamic, inclusion: { in: [true, false] }

  validates :key, uniqueness: { scope: :store_id }
  validates :url, uniqueness: { scope: :store_id }

  delegate :content, to: :page_template

  def draft?
    status == Statuses::DRAFT
  end
end
