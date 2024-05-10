# frozen_string_literal: true

module Addresses
  class Create < ApplicationService
    ATTRIBUTES = %i[address city state country postal_code].freeze

    attr_accessor :store, :fingerprint, :record
    attr_writer :payload

    validates :store, :fingerprint, :record, presence: true
    validate if: :address do
      validate_model(address, :base, *ATTRIBUTES)
    end

    def address
      @_address ||= Address.new(
        store: store,
        record: record,
        created_by: fingerprint
      ).tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      address.save!
    end
  end
end
