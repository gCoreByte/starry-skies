# frozen_string_literal: true

class PageTemplate < ApplicationRecord
  module Statuses
    DRAFT = 'draft'
    ACTIVE = 'active'
    ALL = [DRAFT, ACTIVE].freeze
  end

  nullify_and_strip_attributes :key

  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  has_many :pages, dependent: nil
  has_many :page_template_changes, dependent: nil
  has_many :page_translations, dependent: :destroy

  validates :key, :status, :based_on, presence: true
  validates :status, inclusion: { in: Statuses::ALL }, allow_nil: true
  validates :key, uniqueness: { scope: :store_id }
  validates :key, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :based_on, inclusion: { in: BasedOns::BasedOn.possible_based_ons }, allow_nil: true

  scope :active, -> { where(status: Statuses::ACTIVE) }

  def draft?
    status == Statuses::DRAFT
  end

  def translation_for(locale)
    page_translations.find_by(locale: locale) || page_translations.first
  end

  def content
    translation_for(I18n.locale)&.content
  end
end
