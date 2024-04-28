# frozen_string_literal: true

module PageTranslations
  class Base < ApplicationService
    ATTRIBUTES = %i[locale content].freeze

    attr_accessor :fingerprint
    attr_writer :payload

    validates :page_translation, :payload, :fingerprint, presence: true

    validate if: :page_translation do
      validate_model(page_translation, :base, *ATTRIBUTES)
    end

    delegate(*ATTRIBUTES, to: :page_translation)

    def page_translation
      raise NotImplementedError
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      page_translation.save!
    end
  end
end
