# frozen_string_literal: true

module AdminStorePermissions
  class Destroy < ApplicationService
    attr_accessor :admin_store_permission, :fingerprint

    validates :admin_store_permission, :fingerprint, presence: true

    protected

    def perform
      admin_store_permission.destroy!
    end
  end
end
