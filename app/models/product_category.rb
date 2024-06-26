# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  has_many :product_version_categories, dependent: nil
  has_many :product_versions, through: :product_version_categories
  has_many :products, through: :product_versions

  nullify_attributes :name, :key

  validates :name, :key, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :key, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :key, uniqueness: { scope: :store_id }, allow_nil: true
end
