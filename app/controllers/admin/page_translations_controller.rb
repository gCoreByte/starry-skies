# frozen_string_literal: true

module Admin
  class PageTranslationsController < Admin::ApplicationController
    before_action :set_page_template, only: %i[new create]
    before_action :set_page_translation, except: %i[new create]

    def show
      @record =
        if @page_template.based_on == 'store'
          @store
        else
          FactoryBot.build(@page_template.based_on.to_sym, store: @store)
        end
      I18n.with_locale(params[:locale]) do
        @service = Pages::Render.new(page: @page_template, record: @record)
        @content = @service.render
      end
    end

    def new
      @service = PageTranslations::Create.new(page_template: @page_template, fingerprint: fingerprint)
      @page_translation = @service.page_translation
    end

    def edit
      @page_template = nil
      @service = PageTranslations::Update.new(page_translation: @page_translation, fingerprint: fingerprint)
    end

    def create # rubocop:disable Metrics/MethodLength
      @service = PageTranslations::Create.new(page_template: @page_template, fingerprint: fingerprint,
                                              payload: create_params)
      @page_translation = @service.page_translation
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_page_template_url(@page_template) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update # rubocop:disable Metrics/MethodLength
      @page_template = nil
      @service = PageTranslations::Update.new(page_translation: @page_translation, payload: update_params,
                                              fingerprint: fingerprint)
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_page_template_url(@page_translation.page_template) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @service = PageTranslations::Destroy.new(page_translation: @page_translation, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_page_template_url(@page_template)
    end

    private

    def set_page_template
      @page_template = @store.page_templates.find(params[:page_template_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_page_translation
      @page_translation = @store.page_translations.find(params[:id])
      @page_template = @page_translation.page_template
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def create_params
      params.require(:page_translation).permit(*PageTranslations::Create::ATTRIBUTES)
    end

    def update_params
      params.require(:page_translation).permit(*PageTranslations::Update::ATTRIBUTES)
    end
  end
end
