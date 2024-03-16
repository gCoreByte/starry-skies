# frozen_string_literal: true

class PurchaseCartItem < ApplicationRecord
  belongs_to :store
  belongs_to :purchase_cart
  belongs_to :product_version
  belongs_to :product_price

  validate do
    validate_record_store(purchase_cart)
    validate_record_store(product_version)
    validate_record_store(product_price)
  end

  validate if: %i[product_version product_price] do
    raise 'Product version mismatch' if product_version_id != product_price.product_version_id
  end
end
