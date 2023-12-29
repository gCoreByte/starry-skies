# frozen_string_literal: true

class AdminAccount < ApplicationRecord
  has_secure_password

  validates :email, :display_name, :name, presence: true
  validates :email, length: { maximum: 100 }, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    allow_nil: true
  validates :display_name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :password, allow_nil: true, length: { minimum: 8 }

  normalizes :email, with: ->(email) { email&.strip&.downcase }
  normalizes :display_name, with: ->(display_name) { display_name&.strip }
  normalizes :name, with: ->(name) { name&.strip }

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end
  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  has_many :sessions, dependent: :destroy

  # FIXME: Move to service
  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  # FIXME: Move to service
  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end
end
