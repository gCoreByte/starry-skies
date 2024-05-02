# frozen_string_literal: true

class UserSession < ApplicationRecord
  EXPIRY_PERIOD = 24.hours

  belongs_to :store
  belongs_to :user_account, optional: true
  has_many :fingerprints, dependent: :nullify
  has_many :purchase_carts, dependent: :nullify

  validates :cookie, :expires_at, presence: true
  validates :cookie, uniqueness: { scope: :store_id }, allow_nil: true
  validates :expires_at, comparison: { greater_than: -> { Time.zone.now } }, allow_nil: true
end
