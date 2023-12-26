# frozen_string_literal: true

class Admin < ApplicationRecord
  has_secure_password

  validates :email, :display_name, :name, presence: true
  # FIXME: Add validation for email format
  validates :email, length: { maximum: 100 }, allow_nil: true
  validates :display_name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true

  normalizes :email, with: ->(email) { email&.strip&.downcase }
end
