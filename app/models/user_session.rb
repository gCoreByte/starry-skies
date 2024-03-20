# frozen_string_literal: true

class UserSession < ApplicationRecord
  EXPIRY_PERIOD = 24.hours

  belongs_to :store
  belongs_to :user_account, optional: true

  validates :cookie, :expires_at, presence: true
  validates :cookie, uniqueness: { scope: :store_id }, allow_nil: true
  validates :expires_at, timeliness: { after: -> { Time.zone.now } }, allow_nil: true
end
