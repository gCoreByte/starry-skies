# frozen_string_literal: true

class PurchaseBilling < ApplicationRecord
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :purchase_order

  validates :first_name, :surname, :phone_number, presence: true
  # FIXME: add better name validation
  validates :first_name, length: { maximum: 255 }, allow_nil: true
  validates :surname, length: { maximum: 255 }, allow_nil: true
  # FIXME: add phone number validation
  validates :phone_number, length: { maximum: 255 }, allow_nil: true
end
