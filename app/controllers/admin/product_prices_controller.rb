# frozen_string_literal: true

module Admin
  class ProductPricesController < Admin::ApplicationController
    before_action :set_product_price, only: %i[show edit update destroy]
    before_action :set_product_version, only: %i[new create]
    before_action :set_user_group, only: %i[new create edit update]

    def show
    end

    def new
      @service = ProductPrices::Create.new(
        product_version: @product_version, fingerprint: fingerprint
      )
      @product_price = @service.product_price
    end

    def edit
      @service = ProductPrices::Update.new(
        product_price: @product_price, fingerprint: fingerprint
      )
    end

    def create # rubocop:disable Metrics/MethodLength
      @service = ProductPrices::Create.new(
        product_version: @product_version, user_group: @user_group, fingerprint: fingerprint, payload: create_params
      )
      @product_price = @service.product_price
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_product_version_url(@product_version) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update # rubocop:disable Metrics/MethodLength
      @service = ProductPrices::Update.new(
        product_price: @product_price, user_group: @user_group, fingerprint: fingerprint, payload: update_params
      )
      if service.save
        respond_to do |format|
          format.html { redirect_to admin_product_version_url(@product_version) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @service = ProductPrices::Destroy.new(product_price: @product_price, fingerprint: fingerprint)
      @product_version = @product_price.product_version
      if @service.save
        flash.notice = 'Product price was successfully destroyed.'
      else
        flash.alert = 'Product price could not be destroyed.'
      end
      redirect_to admin_product_version_url(@product_version)
    end

    private

    def set_product_price
      @product_price = @store.product_prices.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_user_group
      return if params.dig(:product_price, :user_group_id).blank?

      @user_group = @store.user_groups.find(params.dig(:product_price, :user_group_id))
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_product_version
      @product_version = @store.product_versions.find(params[:product_version_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def create_params
      params.require(:product_price).permit(*ProductPrices::Create::ATTRIBUTES)
    end

    def update_params
      params.require(:product_price).permit(*ProductPrices::Update::ATTRIBUTES)
    end
  end
end
