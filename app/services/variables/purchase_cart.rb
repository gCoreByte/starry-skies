# frozen_string_literal: true

module Variables
  class PurchaseCart < Variables::Base
    def variables
      %w[id purchase_cart_items]
    end

    delegate :id, to: :record

    def purchase_cart_items
      record.purchase_cart_items.map do |purchase_cart_item|
        Variables::VariableProvider.new(record: purchase_cart_item)
      end
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
