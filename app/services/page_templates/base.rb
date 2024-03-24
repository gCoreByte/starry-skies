# frozen_string_literal: true

module PageTemplates
  class Base < ApplicationService
    ATTRIBUTES = %i[content key based_on].freeze

    attr_accessor :fingerprint
    attr_writer :payload

    validates :page_template, :payload, :fingerprint, presence: true

    validate if: :page_template do
      validate_model(page_template, :base, *ATTRIBUTES)
    end

    def page_template
      raise NotImplementedError
    end

    def page_template_change
      @_page_template_change ||= PageTemplateChange.new(
        store: store,
        page_template: page_template,
        content: page_template.content,
        status: page_template.status,
        key: page_template.key,
        created_by: fingerprint
      )
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      page_template.save!
      page_template_change.save!
    end
  end
end
