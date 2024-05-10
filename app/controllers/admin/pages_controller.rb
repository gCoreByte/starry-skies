# frozen_string_literal: true

module Admin
  class PagesController < Admin::ApplicationController
    before_action :set_page, except: %i[new create index]
    before_action :set_page_template, only: %i[create]

    def index
      @pages = @store.pages
    end

    def show
    end

    def new
      @service = Pages::Create.new(store: @store, page_template: @page_template, fingerprint: fingerprint)
      @page = @service.page
    end

    # TODO: Index is mandatory, lets just not let them edit any of them
    # def edit
    #   @service = Pages::Update.new(page: @page, fingerprint: fingerprint)
    # end

    def create # rubocop:disable Metrics/MethodLength
      @service = Pages::Create.new(store: @store, page_template: @page_template, fingerprint: fingerprint,
                                   payload: create_params)
      @page = @service.page
      if @service.save
        respond_to do |format|
          format.html { redirect_to admin_page_url(@page) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    # def update
    #   @service = Pages::Update.new(page: @page, payload: update_params, fingerprint: fingerprint)
    #   if @service.save
    #     respond_to do |format|
    #       format.html { redirect_to admin_page_url(@page) }
    #       format.turbo_stream
    #     end
    #   else
    #     render :edit, status: :unprocessable_entity
    #   end
    # end

    def destroy
      @service = Pages::Destroy.new(page: @page, fingerprint: fingerprint)
      if @service.save
        flash.notice = 'Page was successfully destroyed.'
        redirect_to admin_store_pages_url(@store)
      else
        flash.alert = 'Page could not be destroyed.'
        redirect_to admin_page_url(@page)
      end
    end

    def draft
      @service = PageStatuses::Draft.new(page: @page, fingerprint: fingerprint)
      if @service.save
        flash.notice = 'Page successfully turned to draft.'
      else
        flash.alert = 'Failed to turn page to draft.'
      end
      redirect_to admin_page_url(@page)
    end

    def live
      @service = PageStatuses::Live.new(page: @page, fingerprint: fingerprint)
      if @service.save
        flash.notice = 'Page successfully turned to live.'
      else
        flash.alert = 'Failed to turn page to live.'
      end
      redirect_to admin_page_url(@page)
    end

    private

    def set_page
      @page = @store.pages.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_page_template
      @page_template = @store.page_templates.find(params.dig(:page, :page_template_id))
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def create_params
      params.require(:page).permit(*Pages::Create::ATTRIBUTES)
    end

    def update_params
      params.require(:page).permit(*Pages::Update::ATTRIBUTES)
    end
  end
end
