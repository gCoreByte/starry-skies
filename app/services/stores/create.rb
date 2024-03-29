# frozen_string_literal: true

module Stores
  class Create < ApplicationService
    ATTRIBUTES = %i[name url locales].freeze

    attr_accessor :admin_account, :fingerprint
    attr_writer :payload

    validate do
      validate_model(store, :base, *ATTRIBUTES)
      validate_model(relationship_service, :base)
    end

    def store
      @_store ||= Store.new(
        created_by: fingerprint,
        updated_by: fingerprint,
        package: package # FIXME
      ).tap do |store|
        store.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      store.save!
      relationship_service.save!
    end

    private

    def relationship_service
      @_relationship_service ||= AdminStoreRelationships::Create.new(
        admin_account: admin_account,
        store: store,
        type_key: AdminStoreRelationship::TypeKeys::ADMIN,
        fingerprint: fingerprint
      )
    end

    def package
      @_package ||= Package.find_by!(key: 'pro')
    end
  end
end
