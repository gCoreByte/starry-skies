# frozen_string_literal: true

class UserAccount < ApplicationRecord
  has_secure_password

  has_many :user_sessions, dependent: :destroy
  has_many :fingerprints, dependent: nil
  belongs_to :store

  validates :email, presence: true
  validates :email, length: { maximum: 100 }, uniqueness: { scope: :store_id },
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    allow_nil: true
  validates :password, length: { minimum: 8 }, allow_nil: true

  normalizes :email, with: ->(email) { email&.strip&.downcase }

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  # FIXME: Move to service
  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  # FIXME: Move to service
  after_update if: :password_digest_previously_changed? do
    user_sessions.where.not(id: Current.user_session).delete_all
  end
end
