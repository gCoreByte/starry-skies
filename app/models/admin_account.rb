# frozen_string_literal: true

class AdminAccount < ApplicationRecord
  has_secure_password

  has_many :sessions, dependent: :destroy
  has_many :admin_store_permissions, dependent: nil
  has_many :admin_store_relationships, dependent: nil
  has_many :stores, through: :admin_store_relationships
  has_many :fingerprints, dependent: nil

  validates :email, :name, presence: true
  validates :email, length: { maximum: 100 }, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP },
                    allow_nil: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true

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
    sessions.where.not(id: Current.session).delete_all
  end
end
