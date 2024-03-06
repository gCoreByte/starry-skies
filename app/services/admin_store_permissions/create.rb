# frozen_string_literal: true

module AdminStorePermissions
  class Create < ApplicationService
    attr_accessor :admin_account, :store, :type_key, :fingerprint

    validates :admin_account, :store, :type_key, :fingerprint, presence: true

    validate if: %i[admin_account store type_key] do
      next errors.add(:base, :account_not_linked_to_store) unless admin_account.stores.include?(store)

      validate_model(admin_store_permission, :admin_account, :store, :type_key)
    end

    def admin_store_permission
      @_admin_store_permission ||= AdminStorePermission.new(
        admin_account: admin_account,
        store: store,
        type_key: type_key,
        created_by: fingerprint
      )
    end

    protected

    def perform
      admin_store_permission.save!
    end
  end
end
