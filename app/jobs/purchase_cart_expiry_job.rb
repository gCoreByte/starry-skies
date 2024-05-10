# frozen_string_literal: true

class PurchaseCartExpiryJob < ApplicationJob
  queue_as :default

  def perform(purchase_cart)
    return if purchase_cart.expired? || purchase_cart.expires_at.future?

    service = PurchaseCartStatuses::Expire.new(purchase_cart: purchase_cart)
    service.save!
  end
end
