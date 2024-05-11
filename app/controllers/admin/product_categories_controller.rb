# frozen_string_literal: true

module Admin
  class ProductCategoriesController < Admin::ApplicationController
    before_action :set_product_category, except: %i[new create index]

    def index
      @product_categories = @store.product_categories
    end

    def show
      @product_versions = ProductVersion.joins(:product_version_categories).where(
        product_version_categories: { product_category: @product_category }
      ).order(updated_at: :desc)
    end

    def new
      @service = ProductCategories::Create.new(store: @store, fingerprint: fingerprint)
      @product_category = @service.product_category
    end

    def edit
      @store = nil # FIXME
      @service = ProductCategories::Update.new(product_category: @product_category, fingerprint: fingerprint)
    end

    def create
      @service = ProductCategories::Create.new(store: @store, fingerprint: fingerprint, payload: create_params)
      @product_category = @service.product_category

      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_product_category_url(@product_category) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update # rubocop:disable Metrics/MethodLength
      @store = nil # FIXME
      @service = ProductCategories::Update.new(
        product_category: @product_category, payload: update_params, fingerprint: fingerprint
      )
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_product_category_url(@product_category) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @service = ProductCategories::Destroy.new(product_category: @product_category, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_store_product_categories_url(@store)
    end

    private

    def set_product_category
      @product_category = @store.product_categories.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :not_found, status: :not_found
    end

    def create_params
      params.require(:product_category).permit(*ProductCategories::Create::ATTRIBUTES)
    end

    def update_params
      params.require(:product_category).permit(*ProductCategories::Update::ATTRIBUTES)
    end
  end
end
