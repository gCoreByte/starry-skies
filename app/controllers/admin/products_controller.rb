# frozen_string_literal: true

module Admin
  class ProductsController < Admin::ApplicationController
    before_action :set_store, only: %i[index new create]
    before_action :set_product, only: %i[show edit update destroy]

    def index
      @products = Product.all
    end

    def show
    end

    def new
      @product = Product.new
    end

    def edit
    end

    def create
      @product = Product.new(create_params)

      if @product.save
        redirect_to admin_product_url(@product)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @product.update(update_params)
        redirect_to admin_product_url(@product)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      store = @product.store
      @product.destroy!

      redirect_to admin_store_products_url(store: store)
    end

    private

    def set_store
      @store = Store.find(params[:store_id])
    rescue ActiveRecord::RecordNotFound
      render :not_found, status: :not_found
    end

    def set_product
      @product = Product.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render :not_found, status: :not_found
    end

    def create_params
      params.require(:product).permit(:name, :key).merge!(
        store: @store, updated_by: fingerprint, created_by: fingerprint
      )
    end

    def update_params
      params.require(:product).permit(:name, :key).merge!(updated_by: fingerprint)
    end
  end
end
