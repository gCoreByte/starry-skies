# frozen_string_literal: true

module BasedOns
  class ProductPrice < BasedOns::Base
    delegate :store, :product_version, :product, to: :record

    def provides
      %w[store product_price product product_version]
    end

    def product_price
      record
    end
  end
end
