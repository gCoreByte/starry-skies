# frozen_string_literal: true

module PageTemplates
  class Base < ApplicationService
    ATTRIBUTES = %i[key based_on].freeze

    attr_accessor :fingerprint
    attr_writer :payload

    validates :page_template, :payload, :fingerprint, presence: true

    validate if: :page_template do
      validate_model(page_template, :base, *ATTRIBUTES)
    end

    delegate(*ATTRIBUTES, to: :page_template)

    def page_template
      raise NotImplementedError
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      page_template.save!
    end
  end
end
