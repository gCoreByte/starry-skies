# frozen_string_literal: true

module PurchaseOrders
  class Create < PurchaseOrders::Base
    attr_accessor :store, :purchase_cart, :address_attributes

    validates :store, :purchase_cart, presence: true

    validate if: :address_service do
      validate_model(address_service, :base, *Addresses::Create::ATTRIBUTES)
    end

    def purchase_order # rubocop:disable Metrics/MethodLength
      @_purchase_order ||= PurchaseOrder.new(
        store: store,
        purchase_cart: purchase_cart,
        status: PurchaseOrder::Statuses::CREATED,
        address: address,
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
      super
      address_service.save!
    end

    private

    def address_service
      @_address_service ||= Addresses::Create.new(
        store: store,
        fingerprint: fingerprint,
        payload: address_attributes
      )
    end
  end
end
