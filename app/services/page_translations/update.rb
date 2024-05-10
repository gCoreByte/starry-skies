# frozen_string_literal: true

module PageTranslations
  class Update < PageTranslations::Base
    attr_writer :page_translation

    def page_translation
      @_page_translation ||= @page_translation.tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      return unless page_translation.changed?

      page_translation.save!
    end
  end
end
