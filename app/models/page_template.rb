# frozen_string_literal: true

class PageTemplate < ApplicationRecord
  module Statuses
    DRAFT = 'draft'
    ACTIVE = 'active'
    ALL = [DRAFT, ACTIVE].freeze
  end

  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  has_many :pages, dependent: nil
  has_many :page_template_changes, dependent: nil

  validates :key, :content, :status, :based_on, presence: true
  validates :status, inclusion: { in: Statuses::ALL }, allow_nil: true
  validates :key, uniqueness: { scope: :store_id }
  validates :based_on, inclusion: { in: BasedOns::BasedOn.possible_based_ons }, allow_nil: true
  validates :content, length: { maximum: 100_000 }, allow_nil: true

  def draft?
    status == Statuses::DRAFT
  end
end
