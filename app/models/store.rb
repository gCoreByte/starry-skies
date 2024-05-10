# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :admin_store_permissions, dependent: :destroy
  has_many :admin_accounts, through: :admin_store_relationships

  has_many :products, dependent: :destroy
  has_many :product_versions, dependent: :destroy
  has_many :product_categories, dependent: :destroy
  has_many :product_version_categories, dependent: :destroy
  has_many :product_prices, dependent: :destroy
  has_many :purchase_orders, dependent: :destroy
  has_many :pages, dependent: :destroy
  has_many :page_templates, dependent: :destroy
  has_many :page_translations, dependent: :destroy
  has_many :user_groups, dependent: :destroy
  has_many :purchase_carts, dependent: :destroy
  has_many :user_accounts, dependent: :destroy
  has_many :user_sessions, dependent: :destroy
  has_many :user_user_groups, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :admin_store_relationships, dependent: :destroy

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
