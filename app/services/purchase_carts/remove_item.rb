# frozen_string_literal: true

module PurchaseCarts
  class RemoveItem < ApplicationService
    attr_accessor :purchase_cart, :fingerprint
    attr_writer :payload

    ATTRIBUTES = %i[key quantity].freeze

    validates :purchase_cart, :fingerprint, :key, :product, presence: true
    validates :quantity, numericality: { only_integer: true, greater_than: 0 }
    validate if: :product_cart_item do
      validate_model(product_cart_item, :base, :quantity, :total_price)
    end

    delegate :store, to: :purchase_cart
    delegate :product_version, to: :product
    delegate :product_price, to: :product_version
    delegate :price, to: :product_price

    def payload
      @_payload ||= @payload || {}
    end

    def quantity
      payload[:quantity].to_i
    end

    def key
      payload[:key]
    end

    def product
      @_product = store.products.active.find_by(key: key)
    end

    def purchase_cart_item
      @_purchase_cart_item ||= purchase_cart.purchase_cart_items.find_by(product_version: product_version)
    end

    protected

    def perform
      if new_quantity.zero?
        purchase_cart_item.destroy!
      else
        purchase_cart_item.update!(quantity: new_quantity, total_price: new_total_price)
      end
    end

    def new_total_price
      price * new_quantity
    end

    def new_quantity
      [purchase_cart_item.quantity - quantity, 0].max
    end
  end
end