# frozen_string_literal: true

class PurchaseOrder < ApplicationRecord
  module Statuses
    CREATED = 'created'
    PROCESSING = 'processing'
    IN_TRANSIT = 'in_transit'
    COMPLETED = 'completed'
    FAILED = 'failed' # something went wrong
    ALL = [CREATED, PROCESSING, IN_TRANSIT, COMPLETED, FAILED].freeze
    FINAL = [COMPLETED, FAILED].freeze
  end

  belongs_to :store
  belongs_to :purchase_cart
  has_one :address, as: :record, dependent: nil

  validates :status, :first_name, :surname, :phone_number, :source, presence: true
  validates :status, inclusion: { in: Statuses::ALL }, allow_nil: true
  # FIXME: add better name validation
  validates :first_name, length: { maximum: 255 }, allow_nil: true
  validates :surname, length: { maximum: 255 }, allow_nil: true
  # FIXME: add phone number validation
  validates :phone_number, length: { maximum: 255 }, allow_nil: true

  validate if: :purchase_cart do
    raise 'Store mismatch' if purchase_cart.store_id != store_id
  end
end
