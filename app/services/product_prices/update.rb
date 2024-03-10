# frozen_string_literal: true

module ProductPrices
  class Update < ProductPrices::Base
    attr_writer :product_price

    def product_price
      @_product_price ||= @product_price.tap do |product_price|
        product_price.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      return unless product_price.changed?

      product_price.updated_by = fingerprint
      product_price.save!
    end
  end
end
