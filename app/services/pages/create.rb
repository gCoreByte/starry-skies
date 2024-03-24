# frozen_string_literal: true

module Pages
  class Create < Pages::Base
    attr_accessor :store, :page_template

    def page
      @_page ||=
        Page.new(
          store: store,
          page_template: page_template,
          status: Page::Statuses::DRAFT,
          created_by: fingerprint,
          updated_by: fingerprint
        ).tap do |page|
          page.assign_attributes(payload.slice(*ATTRIBUTES))
        end
    end
  end
end
