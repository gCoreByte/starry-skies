# frozen_string_literal: true

module PurchaseOrders
  class Create < PurchaseOrders::Base
    attr_accessor :store, :purchase_cart

    validates :store, :purchase_cart, presence: true

    def purchase_order
      @_purchase_order ||= PurchaseOrder.new(
        store: store,
        purchase_cart: purchase_cart,
        status: PurchaseOrder::Statuses::CREATED,
        created_by: fingerprint,
        updated_by: fingerprint
      ).tap do |purchase_order|
        purchase_order.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end
  end
end
