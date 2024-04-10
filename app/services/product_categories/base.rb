# frozen_string_literal: true

module ProductCategories
  class Base < ApplicationService
    ATTRIBUTES = %i[name key].freeze

    attr_accessor :fingerprint
    attr_writer :payload

    validates :payload, :fingerprint, presence: true

    validate if: :product_category do
      validate_model(product_category, :base, *ATTRIBUTES)
    end

    delegate(*ATTRIBUTES, to: :product_category)

    def product_category
      raise 'Implement in subclass'
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      product_category.save!
    end
  end
end
