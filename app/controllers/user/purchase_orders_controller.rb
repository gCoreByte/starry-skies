# frozen_string_literal: true

module User
  class PurchaseOrdersController < User::ApplicationController
    def new
      @service = PurchaseOrders::Create.new(store: @store, purchase_cart: @purchase_cart)
      @purchase_order = @service.purchase_order
    end

    def create
      @service = PurchaseOrders::Create.new(
        store: @store, purchase_cart: @purchase_cart, payload: purchase_order_params, fingerprint: fingerprint
      )
      @purchase_order = @service.purchase_order
      if @service.save
        redirect_to success_purchase_orders_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def success
    end

    private

    def purchase_order_params
      params.require(:purchase_order).permit(
        PurchaseOrders::Create::ATTRIBUTES + PurchaseOrders::Create::ADDRESS_ATTRIBUTES
      )
    end
  end
end
