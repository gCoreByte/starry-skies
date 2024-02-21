# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :admin_store_permissions, dependent: nil
  has_many :admin_store_relationships, dependent: nil
  has_many :admin_accounts, through: :admin_store_relationships

  belongs_to :package

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :url, length: { maximum: 100 }, allow_nil: true
end
