# frozen_string_literal: true

module Admin
  class ProductVersionsController < Admin::ApplicationController
    before_action :set_product, only: %i[new create index]
    before_action :set_product_version, except: %i[new create index]

    def index
      @product_versions = @product.product_versions
    end

    def show
      @product_version_categories = @product_version.product_version_categories
      @product_prices = @product_version.product_prices.order(locale: :desc, currency: :desc)
    end

    def new
      @service = ProductVersions::Create.new(product: @product, fingerprint: fingerprint)
      @product_version = @service.product_version
    end

    def edit
      @service = ProductVersions::Update.new(product_version: @product_version, fingerprint: fingerprint)
    end

    def create
      @service = ProductVersions::Create.new(product: @product, fingerprint: fingerprint, payload: create_params)
      @product_version = @service.product_version

      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_product_version_url(@product_version) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @service =
        ProductVersions::Update.new(product_version: @product_version, payload: update_params, fingerprint: fingerprint)
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_product_version_url(@product_version) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @service = ProductVersions::Destroy.new(product_version: @product_version, fingerprint: fingerprint)
      @product = @product_version.product
      if @service.save
        flash.notice = 'Product version was successfully destroyed.'
      else
        flash.alert = 'Product version could not be destroyed.'
      end
      redirect_to admin_product_url(@product)
    end

    def activate
      @service = ProductVersions::Activate.new(product_version: @product_version, fingerprint: fingerprint)
      if @service.save
        flash.notice = 'Product version was successfully activated.'
      else
        flash.alert = 'Product version could not be activated.'
      end
      redirect_to admin_product_version_url(@product_version)
    end

    def deactivate
      @service = ProductVersions::Deactivate.new(product_version: @product_version, fingerprint: fingerprint)
      if @service.save
        flash.notice = 'Product version was successfully deactivated.'
      else
        flash.alert = 'Product version could not be deactivated.'
      end
      redirect_to admin_product_version_url(@product_version)
    end

    private

    def set_product
      @product = @store.products.find(params[:product_id])
    rescue ActiveRecord::RecordNotFound
      render :not_found, status: :not_found
    end

    def set_product_version
      @product_version = @store.product_versions.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :not_found, status: :not_found
    end

    def create_params
      params.require(:product_version).permit(*ProductVersions::Create::ATTRIBUTES).merge!(
        store: @store, updated_by: fingerprint, created_by: fingerprint
      )
    end

    def update_params
      params.require(:product_version).permit(*ProductVersions::Update::ATTRIBUTES).merge!(updated_by: fingerprint)
    end
  end
end
