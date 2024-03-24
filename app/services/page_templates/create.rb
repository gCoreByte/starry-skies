# frozen_string_literal: true

module PageTemplates
  class Create < PageTemplates::Base
    attr_accessor :store

    def page_template
      @_page_template ||= PageTemplate.new(
        store: store,
        created_by: fingerprint,
        updated_by: fingerprint
      ).tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end
  end
end
