# frozen_string_literal: true

module AdminAccounts
  class Destroy < ApplicationService
    attr_accessor :admin_account, :fingerprint

    validates :admin_account, :fingerprint, presence: true

    validate do
      errors.add(:base, :cannot_have_any_admin_relationships) if admin_account.admin_store_relationships.admin.exists?
    end

    protected

    def perform # rubocop:disable Metrics/AbcSize
      admin_account.admin_store_relationships.each do |relationship|
        AdminStoreRelationships::Destroy.new(admin_store_relationship: relationship, fingerprint: fingerprint).save!
      end
      admin_account.admin_store_relationships.reload
      admin_account.admin_store_permissions.each do |permission|
        AdminStorePermissions::Destroy.new(admin_store_permission: permission, fingerprint: fingerprint).save!
      end
      admin_account.admin_store_permissions.reload
      admin_account.fingerprints.update_all(admin_account_id: nil) # rubocop:disable Rails/SkipsModelValidations
      admin_account.destroy!
    end
  end
end
