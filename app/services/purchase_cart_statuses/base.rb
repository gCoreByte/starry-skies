# frozen_string_literal: true

module PurchaseCartStatuses
  class Base < ApplicationService
    attr_accessor :purchase_cart, :fingerprint

    validates :purchase_cart, :fingerprint, presence: true

    validate if: :purchase_cart do
      errors.add(:base, :invalid_state) unless valid_state?
    end

    def valid_state?
      purchase_cart.status.in?(from_statuses)
    end

    def from_statuses
      'Implement in subclass'
    end

    def to_status
      'Implement in subclass'
    end

    protected

    def perform
      purchase_cart.update!(status: to_status, updated_by: fingerprint)
    end
  end
end
