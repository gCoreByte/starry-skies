# frozen_string_literal: true

class ProductPricesController < ApplicationController
  before_action :set_product_price, only: %i[show edit update destroy]

  # GET /product_prices or /product_prices.json
  def index
    @product_prices = ProductPrice.all
  end

  # GET /product_prices/1 or /product_prices/1.json
  def show; end

  # GET /product_prices/new
  def new
    @product_price = ProductPrice.new
  end

  # GET /product_prices/1/edit
  def edit; end

  # POST /product_prices or /product_prices.json
  def create
    @product_price = ProductPrice.new(product_price_params)

    if @product_price.save
      redirect_to product_price_url(@product_price)
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /product_prices/1 or /product_prices/1.json
  def update
    if @product_price.update(product_price_params)
      redirect_to product_price_url(@product_price)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /product_prices/1 or /product_prices/1.json
  def destroy
    @product_price.destroy!

    redirect_to product_prices_url
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product_price
    @product_price = ProductPrice.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def product_price_params
    params.require(:product_price).permit(:locale, :price, :currency, :deactivated_at, :store_id, :created_by_id,
                                          :product_version_id)
  end
end
