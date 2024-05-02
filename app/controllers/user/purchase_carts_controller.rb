# frozen_string_literal: true

module User
  class PurchaseCartsController < User::ApplicationController
    before_action :set_product

    def add_item # rubocop:disable Metrics/MethodLength
      unless @purchase_cart
        service = PurchaseCarts::Create.new(store: @store, fingerprint: fingerprint)
        service.save!
        @purchase_cart = @service.purchase_cart
      end

      @service = PurchaseCarts::AddItem.new(purchase_cart: @purchase_cart, payload: item_params,
                                            fingerprint: fingerprint)
      if @service.save
        render :ok
      else
        render :unprocessable_entity
      end
    end

    def remove_item # rubocop:disable Metrics/MethodLength
      unless @purchase_cart
        service = PurchaseCarts::Create.new(store: @store, fingerprint: fingerprint)
        service.save!
        @purchase_cart = @service.purchase_cart
      end

      @service = PurchaseCarts::AddItem.new(purchase_cart: @purchase_cart, payload: item_params,
                                            fingerprint: fingerprint)
      if @service.save
        render :ok
      else
        render :unprocessable_entity
      end
    end

    private

    def item_params
      params.require(:item).permit(:key, :quantity)
    end
  end
end
