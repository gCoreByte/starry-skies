# frozen_string_literal: true

module BasedOns
  class Product < BasedOns::Base
    PROVIDES = %w[store product product_version].freeze

    def provides
      PROVIDES
    end

    delegate :store, :product_version, to: :record

    def product
      record
    end
  end
end
