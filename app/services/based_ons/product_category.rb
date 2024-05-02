# frozen_string_literal: true

module BasedOns
  class ProductVersion < BasedOns::Base
    delegate :store, to: :record

    def provides
      %w[store products product_category]
    end

    def product_category
      record
    end

    def products
      record.products.active.order(key: :asc).to_a
    end
  end
end
