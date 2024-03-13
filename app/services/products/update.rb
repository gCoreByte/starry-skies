# frozen_string_literal: true

module Products
  class Update < Products::Base
    attr_writer :product

    def product
      @_product ||= @product.tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      return unless product.changed?

      product.updated_by = fingerprint
      super
    end
  end
end
