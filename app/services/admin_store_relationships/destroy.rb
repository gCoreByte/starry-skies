# frozen_string_literal: true

module AdminStoreRelationships
  class Destroy < ApplicationService
    attr_accessor :admin_store_relationship, :fingerprint

    validates :admin_store_relationship, :fingerprint, presence: true
    validate if: :admin_store_relationship do
      errors.add(:base, :cannot_remove_admin) if admin_store_relationship.admin?
    end

    protected

    def perform
      admin_store_relationship.destroy!
    end
  end
end
