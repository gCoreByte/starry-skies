# frozen_string_literal: true

class AdminStoreRelationship < ApplicationRecord
  module TypeKeys
    ADMIN = 'admin'
    MANAGER = 'manager'
    USER = 'user'
    ALL = [ADMIN, MANAGER, USER].freeze
  end

  belongs_to :store
  belongs_to :admin_account
  belongs_to :created_by, class_name: 'Fingerprint'

  validates :type_key, presence: true
  validates :type_key, inclusion: { in: TypeKeys::ALL }, allow_nil: true
  validates :admin_account_id, uniqueness: { scope: :store_id }

  TypeKeys::ALL.each do |key|
    define_method("#{key}?") do
      key == type_key
    end

    scope key.to_sym, -> { where(type_key: key) }
  end
end
