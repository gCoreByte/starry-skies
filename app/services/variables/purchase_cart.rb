# frozen_string_literal: true

module Variables
  class PurchaseCart < Variables::Base
    def variables
      %w[id purchase_cart_items item_count total_price]
    end

    delegate :id, to: :record

    def purchase_cart_items
      record.purchase_cart_items.order(:created_at).map do |purchase_cart_item|
        Variables::VariableProvider.new(record: purchase_cart_item)
      end
    end

    def item_count
      record.purchase_cart_items.sum(&:quantity)
    end

    def total_price
      record.purchase_cart_items.sum(&:total_price)
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
