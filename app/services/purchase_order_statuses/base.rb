# frozen_string_literal: true

module PurchaseOrderStatuses
  class Base < ApplicationService
    attr_accessor :purchase_order, :fingerprint

    validates :purchase_order, :fingerprint, presence: true

    validate if: :purchase_order do
      errors.add(:base, :invalid_state) unless valid_state?
    end

    def valid_state?
      purchase_order.status.in?(from_statuses)
    end

    def from_statuses
      'Implement in subclass'
    end

    def to_status
      'Implement in subclass'
    end

    protected

    def perform
      purchase_order.update!(status: to_status, updated_by: fingerprint)
    end
  end
end
