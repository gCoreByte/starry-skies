# frozen_string_literal: true

module ProductPrices
  class Create < ProductPrices::Base
    attr_accessor :product_version

    validates :product_version, presence: true

    delegate :store, to: :product_version

    def product_price
      @_product_price ||=
        ProductPrice.new(
          product_version: product_version,
          store: store,
          created_by: fingerprint,
          updated_by: fingerprint,
          user_group: user_group
        ).tap do |product_price|
          product_price.assign_attributes(payload.slice(*ATTRIBUTES))
        end
    end
  end
end
