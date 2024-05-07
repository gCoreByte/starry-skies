# frozen_string_literal: true

module User
  class PagesController < User::ApplicationController
    before_action :set_page
    before_action :set_record

    def show
      return render_404 unless @record

      @service = Pages::Render.new(page: @page, record: @record, variables: { 'purchase_cart' => @purchase_cart })
      @content = @service.render
    end

    private

    def set_page
      @page = @store.pages.find_by(url: page_slug)
    end

    def set_record
      @record = @store if @page.based_on == 'store'
      return unless @page.based_on != 'store'

      @record = @page.based_on.classify.safe_constantize.find_by(store: @store, id: params[:record_id])
    end

    def page_slug
      params[:slug] || 'index'
    end
  end
end
