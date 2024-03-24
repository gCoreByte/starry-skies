# frozen_string_literal: true

module BasedOns
  class Product < BasedOns::Base
    delegate :store, :product_version, to: :record

    def provides
      %w[store product product_version]
    end

    def product
      record
    end
  end
end
