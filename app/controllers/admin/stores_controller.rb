# frozen_string_literal: true

module Admin
  class StoresController < Admin::ApplicationController
    before_action :set_store, only: %i[show edit update destroy]

    def index
      @stores = current_user.stores.all
    end

    def show
    end

    def new
      @store = Store.new
    end

    def edit
    end

    def create
      @store = Store.new(store_params)

      if @store.save
        redirect_to admin_store_url(@store)
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @store.update(store_params)
        redirect_to admin_store_url(@store)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @store.destroy!

      redirect_to admin_stores_url
    end

    private

    def set_store
      @store = Store.find(params[:id])
    end

    def store_params
      params.require(:store).permit(:name, :url, locales: [])
    end
  end
end
