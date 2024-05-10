# frozen_string_literal: true

module BasedOns
  class ProductVersion < BasedOns::Base
    delegate :store, :product, :product_price, to: :record

    def provides
      %w[store product product_version product_price]
    end

    def product_version
      record
    end
  end
end
