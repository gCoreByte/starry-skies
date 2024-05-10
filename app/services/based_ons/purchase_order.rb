# frozen_string_literal: true

module BasedOns
  class PurchaseOrder < BasedOns::Base
    delegate :store, to: :record

    def provides
      %w[store purchase_order]
    end

    def purchase_order
      record
    end
  end
end
