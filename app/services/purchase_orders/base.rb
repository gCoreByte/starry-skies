# frozen_string_literal: true

module PurchaseOrders
  class Base < ApplicationService
    ATTRIBUTES = %i[first_name surname phone_number].freeze

    attr_writer :payload
    attr_accessor :fingerprint

    validate if: :purchase_order do
      validate_model(purchase_order, :base, *ATTRIBUTES)
    end

    delegate(*ATTRIBUTES, to: :purchase_order)

    def payload
      @_payload ||= @payload || {}
    end

    def purchase_order
      raise NotImplementedError
    end

    protected

    def perform
      purchase_order.save!
    end
  end
end
