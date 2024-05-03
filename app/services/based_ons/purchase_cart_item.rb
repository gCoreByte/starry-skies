# frozen_string_literal: true

module BasedOns
  class ProductVersion < BasedOns::Base
    delegate :store, :purchase_cart, to: :record

    def provides
      %w[store purchase_cart_item purchase_cart]
    end

    def purchase_cart_item
      record
    end
  end
end
