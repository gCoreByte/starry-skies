# frozen_string_literal: true

module ProductPrices
  class Base < ApplicationService
    ATTRIBUTES = %i[locale price currency].freeze

    attr_accessor :fingerprint
    attr_writer :payload

    validates :product_price, :payload, :fingerprint, presence: true

    validate if: :product_price do
      validate_model(product_price, :base, *ATTRIBUTES)
    end

    def product_price
      raise 'Implement in subclass'
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      product_price.save!
    end
  end
end
