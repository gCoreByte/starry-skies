# frozen_string_literal: true

class ProductPrice < ApplicationRecord
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  belongs_to :product_version
  belongs_to :user_group, optional: true

  validates :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :product_version_id,
            uniqueness: { scope: %i[user_group_id], where: 'deactivated_at IS NULL AND user_group_id IS NOT NULL' }
end
