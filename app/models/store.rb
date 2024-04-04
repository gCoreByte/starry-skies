# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :admin_store_permissions, dependent: nil
  has_many :admin_store_relationships, dependent: nil
  has_many :admin_accounts, through: :admin_store_relationships

  has_many :products, dependent: nil
  has_many :product_versions, dependent: nil

  belongs_to :package, optional: true
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :url, length: { maximum: 100 }, allow_nil: true # FIXME: URL validation
  validates :url, uniqueness: true, allow_nil: true

  def revenue
    # FIXME
    0
  end

  def sales
    # FIXME
    0
  end

  def open_issues
    # FIXME
    0
  end

  def variable_provider
    @_variable_provider ||= VariableProvider.new(record: self)
  end
end
