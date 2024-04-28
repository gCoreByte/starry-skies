# frozen_string_literal: true

module PageTranslations
  class Create < PageTranslations::Base
    attr_accessor :page_template

    validates :page_template, presence: true

    delegate :store, to: :page_template

    def page_translation
      @_page_translation ||= PageTranslation.new(
        store: store,
        page_template: page_template,
        created_by: fingerprint
      ).tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end
  end
end
