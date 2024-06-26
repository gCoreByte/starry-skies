# frozen_string_literal: true

module ProductVersions
  class Base < ApplicationService
    ATTRIBUTES = %i[width length height weight size_unit weight_unit].freeze

    attr_accessor :fingerprint
    attr_writer :payload

    validates :product_version, :fingerprint, presence: true

    validate if: :product_version do
      validate_model(product_version, :base, *ATTRIBUTES)
    end

    delegate(*ATTRIBUTES, to: :product_version)

    def product_version
      raise 'Implement in subclass'
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      product_version.save!
    end
  end
end
