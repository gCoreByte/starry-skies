# frozen_string_literal: true

module BasedOns
  class Store < BasedOns::Base
    def provides
      %w[store products]
    end

    def store
      record
    end

    def products
      record.products.active.order(key: :asc).to_a
    end
  end
end
