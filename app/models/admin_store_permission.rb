# frozen_string_literal: true

class AdminStorePermission < ApplicationRecord
  belongs_to :store
  belongs_to :admin_account

  validates :type_key, presence: true
  validates :type_key, inclusion: { in: self.class.type_keys }, allow_nil: true

  class << self
    def permissions
      @_permissions ||= YAML.load_file(
        Rails.root.join('config/permissions.yml')
      ).with_indifferent_access
    end

    def type_keys
      @_type_keys ||= permissions.keys
    end
  end
end
