# frozen_string_literal: true

module Admin
  class ProductVersionsController < Admin::ApplicationController # rubocop:disable Metrics/ClassLength
    before_action :set_product, only: %i[new create]
    before_action :set_product_version, except: %i[new create]

    def show
      @product_version_categories = @product_version.product_version_categories
      @product_prices = @product_version.product_prices
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
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_product_url(@product)
    end

    def activate
      @service = ProductVersions::Activate.new(product_version: @product_version, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_product_version_url(@product_version)
    end

    def deactivate
      @service = ProductVersions::Deactivate.new(product_version: @product_version, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_product_version_url(@product_version)
    end

    def translations_form
      @translation_service = Translations::Translator.new(record: @product_version)
      @service = ProductVersions::Translations.new(product_version: @product_version, fingerprint: fingerprint)
    end

    def translations # rubocop:disable Metrics/MethodLength
      @translation_service = Translations::Translator.new(record: @product_version)
      @service = ProductVersions::Translations.new(product_version: @product_version, fingerprint: fingerprint,
                                                   payload: translations_params)
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_product_version_url(@product_version) }
          format.turbo_stream
        end
      else
        render :translations_form, status: :unprocessable_entity
      end
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

    def translations_params
      params.require(:product_version).permit(
        en: ProductVersion::TRANSLATABLE_KEYS,
        et: ProductVersion::TRANSLATABLE_KEYS,
        ru: ProductVersion::TRANSLATABLE_KEYS
      )
    end
  end
end
