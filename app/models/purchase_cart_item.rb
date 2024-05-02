# frozen_string_literal: true

class PurchaseCartItem < ApplicationRecord
  belongs_to :store
  belongs_to :purchase_cart
  belongs_to :product_version
  belongs_to :product_price

  validates :quantity, :total_price, presence: true
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }

  validate do
    validate_record_store(purchase_cart)
    validate_record_store(product_version)
    validate_record_store(product_price)
  end

  validate if: %i[product_version product_price] do
    raise 'Product version mismatch' if product_version_id != product_price.product_version_id
  end

  delegate :price, to: :product_price
  delegate :name, :description, to: :product_version
end
