# frozen_string_literal: true

class Product < ApplicationRecord
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'

  has_many :product_versions, dependent: nil
  has_one :product_version, -> { active }, dependent: nil, inverse_of: :product

  validates :name, :key, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :key, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :key, uniqueness: { scope: :store_id }

  scope :active, -> { joins(:product_version) }

  def active?
    product_version.present?
  end

  # TODO: translations logic
  def title
    name
  end
end
