# frozen_string_literal: true

module BasedOns
  class ProductVersion < BasedOns::Base
    delegate :store, :product, to: :record

    def provides
      %w[store product product_version]
    end

    def product_version
      record
    end
  end
end
