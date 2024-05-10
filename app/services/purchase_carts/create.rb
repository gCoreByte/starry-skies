# frozen_string_literal: true

module PurchaseCarts
  class Create < ApplicationService
    attr_accessor :store, :fingerprint

    validates :store, :fingerprint, presence: true

    validate if: :purchase_cart do
      validate_model(purchase_cart, :base, :status, :expires_at)
    end

    def purchase_cart
      @_purchase_cart ||= PurchaseCart.new(
        store: store,
        created_by: fingerprint,
        updated_by: fingerprint,
        user_account: fingerprint.user_account,
        user_session: fingerprint.user_session,
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
