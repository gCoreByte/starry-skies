# frozen_string_literal: true

module AdminStoreRelationships
  class Create < ApplicationService
    attr_accessor :admin_account, :store, :type_key, :fingerprint

    validates :admin_account, :store, :type_key, :fingerprint, presence: true

    validate if: %i[admin_account store type_key] do
      validate_model(admin_store_relationship, :admin_account, :store, :type_key)
    end

    def admin_store_relationship
      @_admin_store_relationship ||= AdminStoreRelationship.new(
        admin_account: admin_account,
        store: store,
        type_key: type_key,
        created_by: fingerprint
      )
    end

    protected

    def perform
      admin_store_relationship.save!
    end
  end
end
