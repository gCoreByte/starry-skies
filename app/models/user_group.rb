# frozen_string_literal: true

class UserGroup < ApplicationRecord
  belongs_to :store
  has_many :product_prices, dependent: :destroy
  has_many :user_user_groups, dependent: :destroy
  has_many :user_accounts, through: :user_user_groups

  validates :name, :key, :ranking, presence: true
  validates :ranking, numericality: { only_integer: true, greater_than: 0 }
  validates :key, :ranking, uniqueness: { scope: %i[store_id] }
end
