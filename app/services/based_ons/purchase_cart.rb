# frozen_string_literal: true

module BasedOns
  class PurchaseCart < BasedOns::Base
    delegate :store, to: :record

    def provides
      %w[store purchase_cart]
    end

    def purchase_cart
      record
    end
  end
end
