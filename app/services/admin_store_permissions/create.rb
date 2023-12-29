# frozen_string_literal: true

module AdminStorePermissions
  class Create < ApplicationService
    attr_accessor :admin_account, :store, :type_key

    validates :admin_account, :store, :type_key, presence: true

    validate if: %i[admin_account store type_key] do
      validate_model(admin_store_permission, :admin_account, :store, :type_key)
    end

    def admin_store_permission
      @_admin_store_permission ||= AdminStorePermission.new(
        admin_account: admin_account,
        store: store,
        type_key: type_key
      )
    end

    protected

    def perform
      admin_store_permission.save!
    end
  end
end
