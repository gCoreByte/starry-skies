# frozen_string_literal: true

module Admin
  class PageTemplatesController < Admin::ApplicationController
    before_action :set_page_template, except: %i[index new create]

    def index
      @page_templates = @store.page_templates
    end

    def show
    end

    def new
      @service = PageTemplates::Create.new(store: @store, fingerprint: fingerprint)
      @page_template = @service.page_template
    end

    def edit
      @store = nil # FIXME
      @service = PageTemplates::Update.new(page_template: @page_template, fingerprint: fingerprint)
    end

    def create
      @service = PageTemplates::Create.new(store: @store, fingerprint: fingerprint, payload: create_params)
      @page_template = @service.page_template
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
      @store = nil
      @service = PageTemplates::Update.new(page_template: @page_template, payload: update_params,
                                           fingerprint: fingerprint)
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_page_template_url(@page_template) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @service = PageTemplates::Destroy.new(page_template: @page_template, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
        redirect_to admin_store_page_templates_url(@store)
      else
        flash.alert = t('.alert')
        redirect_to admin_page_template_url(@page_template)
      end
    end

    def preview # rubocop:disable Metrics/MethodLength
      # FIXME: hack
      @record =
        if @page_template.based_on == 'store'
          @store
        else
          FactoryBot.build(@page_template.based_on.to_sym, store: @store)
        end
      I18n.with_locale(params[:locale]) do
        @service = Pages::Render.new(page: @page_template, record: @record,
                                     variables: { 'purchase_cart' => FactoryBot.build(:purchase_cart, store: @store) })
        @content = @service.render
      end
    end

    def activate
      @service = PageTemplateStatuses::Active.new(page_template: @page_template, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_page_template_url(@page_template)
    end

    def deactivate
      @service = PageTemplateStatuses::Draft.new(page_template: @page_template, fingerprint: fingerprint)
      if @service.save
        flash.notice = t('.success')
      else
        flash.alert = t('.alert')
      end
      redirect_to admin_page_template_url(@page_template)
    end

    private

    def set_page_template
      @page_template = @store.page_templates.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def create_params
      params.require(:page_template).permit(*PageTemplates::Create::ATTRIBUTES)
    end

    def update_params
      params.require(:page_template).permit(*PageTemplates::Update::ATTRIBUTES)
    end
  end
end
