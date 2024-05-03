# frozen_string_literal: true

module Variables
  class PurchaseCartItem < Variables::Base
    def variables
      %w[id name price total_price quantity]
    end

    delegate :id, :price, :total_price, :quantity, :name, to: :record

    def purchase_cart
      Variables::VariableProvider.new(record: based_on_service.purchase_cart)
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
