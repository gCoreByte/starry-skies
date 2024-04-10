# frozen_string_literal: true

module PurchaseCarts
  class Create < ApplicationService
    attr_accessor :fingerprint

    validates :fingerprint, presence: true

    validate if: :purchase_cart do
      validate_model(purchase_cart, :base, :status, :expires_at)
    end

    def purchase_cart
      @_purchase_cart ||= PurchaseCart.new(
        created_by: fingerprint,
        updated_by: fingerprint,
        status: PurchaseCart::Statuses::CREATED,
        expires_at: PurchaseCart::EXPIRY_PERIOD.from_now
      )
    end

    protected

    def perform
      purchase_cart.save!
    end

    def after_commit
      PurchaseCartExpiryJob.set(wait_until: purchase_cart.expires_at).perform_later(purchase_cart)
    end
  end
end
