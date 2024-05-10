# frozen_string_literal: true

module User
  class PurchaseCartsController < User::ApplicationController
    def add_item
      @service = PurchaseCarts::AddItem.new(purchase_cart: @purchase_cart, payload: item_params,
                                            fingerprint: fingerprint)
      if @service.save
        head :ok
      else
        render json: { errors: @service.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end

    def remove_item
      @service = PurchaseCarts::RemoveItem.new(purchase_cart: @purchase_cart, payload: item_params,
                                               fingerprint: fingerprint)
      if @service.save
        head :ok
      else
        render json: { errors: @service.errors.full_messages.join(', ') }, status: :unprocessable_entity
      end
    end

    private

    def item_params
      params.require(:item).permit(:key, :quantity)
    end
  end
end
