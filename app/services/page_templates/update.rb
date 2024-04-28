# frozen_string_literal: true

module PageTemplates
  class Update < PageTemplates::Base
    attr_writer :page_template

    delegate :store, to: :page_template

    def page_template
      @_page_template ||= @page_template.tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      return unless page_template.changed?

      page_template.updated_by = fingerprint
      page_template.save!
      page_template_change.save!
    end
  end
end
