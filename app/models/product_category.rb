# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'

  validates :name, :key, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :key, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :key, uniqueness: { scope: :store_id }
end
