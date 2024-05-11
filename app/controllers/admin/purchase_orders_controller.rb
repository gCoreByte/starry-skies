# frozen_string_literal: true

module Admin
  class PurchaseOrdersController < Admin::ApplicationController
    before_action :set_purchase_order, only: %i[show processing in_transit completed failed]

    def index
      @purchase_orders = @store.purchase_orders.order(created_at: :desc)
    end

    def show
    end

    def new
      @service = PurchaseOrders::Create.new(store: @store, fingerprint: fingerprint)
      @purchase_order = @service.purchase_order
    end

    def create
      @service = PurchaseOrders::ManualCreate.new(store: @store, fingerprint: fingerprint, payload: create_params)
      @purchase_order = @service.purchase_order
      if @service.save
        redirect_to admin_purchase_order_url(@purchase_order)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def processing
      @service = PurchaseOrderStatuses::Processing.new(purchase_order: @purchase_order, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_purchase_order_url(@purchase_order)
    end

    def in_transit
      @service = PurchaseOrderStatuses::InTransit.new(purchase_order: @purchase_order, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_purchase_order_url(@purchase_order)
    end

    def completed
      @service = PurchaseOrderStatuses::Complete.new(purchase_order: @purchase_order, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_purchase_order_url(@purchase_order)
    end

    def failed
      @service = PurchaseOrderStatuses::Fail.new(purchase_order: @purchase_order, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_purchase_order_url(@purchase_order)
    end

    private

    def set_purchase_order
      @purchase_order = @store.purchase_orders.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
