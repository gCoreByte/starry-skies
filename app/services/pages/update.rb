# frozen_string_literal: true

module Pages
  class Update < Pages::Base
    attr_writer :page

    def page
      @_page ||= @page.tap do |page|
        page.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      return unless page.changed?

      page.updated_by = fingerprint
      page.save!
    end
  end
end
