# frozen_string_literal: true

module Admin
  class StoresController < Admin::ApplicationController
    before_action :set_store, only: %i[show edit update destroy]

    def show
    end

    def new
      @store = Store.new
    end

    def edit
    end

    def create
      service = Stores::Create.new(admin_account: current_user, fingerprint: fingerprint, payload: create_params)

      @store = service.store
      if service.save
        respond_to do |format|
          format.html { redirect_to admin_store_url(@store) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @store.update(update_params)
        respond_to do |format|
          format.html { redirect_to admin_store_url(@store) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @store.admin_store_relationships.destroy_all
      @store.destroy!
      cookies.delete(:store_id)

      redirect_to admin_dashboard_index_url
    end

    private

    def set_store
      @store = current_user.stores.find(params[:id])
      cookies[:store_id] = @store.id
    end

    def create_params
      params.require(:store).permit(:name, :url, :example_store, locales: []).merge!(
        created_by: fingerprint, updated_by: fingerprint
      )
    end

    def update_params
      params.require(:store).permit(:name, :url, locales: []).merge!(updated_by: fingerprint)
    end
  end
end
