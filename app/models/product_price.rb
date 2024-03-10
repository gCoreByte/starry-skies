# frozen_string_literal: true

class ProductPrice < ApplicationRecord
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  belongs_to :product_version

  validates :locale, :price, :currency, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true
  validates :currency, uniqueness: { scope: %i[product_version_id locale], where: 'deactivated_at IS NOT NULL' },
                       allow_nil: true
end
