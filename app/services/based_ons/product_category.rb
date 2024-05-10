# frozen_string_literal: true

module BasedOns
  class ProductCategory < BasedOns::Base
    delegate :store, to: :record

    def provides
      %w[store product_category]
    end

    def product_category
      record
    end
  end
end
