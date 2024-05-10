# frozen_string_literal: true

module PurchaseOrders
  class Create < PurchaseOrders::Base
    ADDRESS_ATTRIBUTES = %i[country address state country postal_code].freeze

    attr_accessor :store, :purchase_cart

    validates :store, :purchase_cart, presence: true

    validate if: :purchase_cart do
      errors.add(:base, :no_items) if purchase_cart.purchase_cart_items.empty?
    end

    validate if: :address_service do
      validate_model(address_service, :base, *Addresses::Create::ATTRIBUTES)
    end

    validate if: :purchase_cart_status_service do
      validate_model(purchase_cart_status_service, :base)
    end

    delegate(*ADDRESS_ATTRIBUTES, to: :address)

    def purchase_order
      @_purchase_order ||= PurchaseOrder.new(
        store: store,
        purchase_cart: purchase_cart,
        status: PurchaseOrder::Statuses::CREATED,
        created_by: fingerprint,
        updated_by: fingerprint,
        reference_number: reference_number
      ).tap do |purchase_order|
        purchase_order.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    def address
      @_address ||= address_service.address
    end

    def reference_number
      store.purchase_orders.maximum(:reference_number).to_i + 1
    end

    protected

    def perform
      purchase_cart_status_service.save!
      super
      address_service.save!
    end

    private

    def address_service
      @_address_service ||= Addresses::Create.new(
        store: store,
        fingerprint: fingerprint,
        record: purchase_order,
        payload: payload.slice(*ADDRESS_ATTRIBUTES)
      )
    end

    def purchase_cart_status_service
      @_purchase_cart_status_service ||= PurchaseCartStatuses::Billed.new(
        purchase_cart: purchase_cart,
        fingerprint: fingerprint
      )
    end
  end
end
