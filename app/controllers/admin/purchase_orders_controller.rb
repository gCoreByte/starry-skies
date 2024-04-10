# frozen_string_literal: true

module Admin
  class PurchaseOrdersController < Admin::ApplicationController
    def index
      @purchase_orders = @store.purchase_orders
    end

    def show
    end

    def new
    end

    def edit
    end

    def create
    end

    def update
    end

    def processing
    end

    def in_transit
    end

    def completed
    end

    def failed
    end

    private

    def set_purchase_order
      @purchase_order = @store.purchase_orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
