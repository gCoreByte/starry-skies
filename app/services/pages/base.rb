# frozen_string_literal: true

module Pages
  class Base < ApplicationService
    ATTRIBUTES = %i[key url dynamic].freeze

    attr_accessor :fingerprint
    attr_writer :payload

    validates :page, :payload, :fingerprint, presence: true

    validate if: :page do
      validate_model(page, :base, *ATTRIBUTES)
    end

    def page
      raise 'Implement in subclass'
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      page.save!
    end
  end
end
