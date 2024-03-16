# frozen_string_literal: true

FactoryBot.define do
  factory :purchase_cart_item do
    store { @overrides[:purchase_cart]&.store || association(:store) }
    purchase_cart { association(:purchase_cart, store: store) }
    product_version { association(:product_version, store: store) }
    product_price { association(:product_price, product_version: product_version) }
    quantity { 1 }
    total_price { product_price.price * quantity }
  end
end
