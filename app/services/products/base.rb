# frozen_string_literal: true

module Products
  class Base < ApplicationService
    ATTRIBUTES = %i[key].freeze

    attr_writer :payload
    attr_accessor :fingerprint

    validates :payload, :product, :fingerprint, presence: true

    validate if: :product do
      validate_model(product, :base, *ATTRIBUTES)
    end

    def payload
      @_payload ||= @payload || {}
    end

    def product
      raise 'Implement in subclass'
    end

    protected

    def perform
      product.save!
    end
  end
end
