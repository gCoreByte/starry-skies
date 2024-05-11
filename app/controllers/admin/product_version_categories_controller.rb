# frozen_string_literal: true

module Admin
  class ProductVersionCategoriesController < Admin::ApplicationController
    before_action :set_product_version_category, only: %i[destroy]
    before_action :set_product_version, only: %i[new create]
    before_action :set_product_category, only: %i[create]

    def new
      @service = ProductVersionCategories::Create.new(
        product_version: @product_version, product_category: @product_category, fingerprint: fingerprint
      )
      @product_version_category = @service.product_version_category
    end

    def create # rubocop:disable Metrics/MethodLength
      @service = ProductVersionCategories::Create.new(product_version: @product_version, store: @store,
                                                      product_category: @product_category, fingerprint: fingerprint)
      @product_version_category = @service.product_version_category

      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_product_version_url(@product_version) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @service = ProductVersionCategories::Destroy.new(product_version_category: @product_version_category,
                                                       fingerprint: fingerprint)
      @product_version = @product_version_category.product_version
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_product_version_url(@product_version)
    end

    private

    def set_product_version_category
      @product_version_category = @store.product_version_categories.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_product_version
      @product_version = @store.product_versions.find(params[:product_version_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_product_category
      @product_category = @store.product_categories.find_by(id: create_params[:product_category_id])
    end

    def create_params
      return {} unless params.key?(:product_version_category)

      params.require(:product_version_category).permit(:product_category_id)
    end
  end
end
