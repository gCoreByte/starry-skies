# frozen_string_literal: true

class PurchaseCart < ApplicationRecord
  EXPIRY_PERIOD = 24.hours

  module Statuses
    CREATED = 'created'
    BOOKED = 'booked'
    BILLED = 'billed'
    EXPIRED = 'expired'
    ALL = [CREATED, BOOKED, BILLED, EXPIRED].freeze
    FINAL = [BILLED, EXPIRED].freeze
  end

  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  has_many :purchase_cart_items, dependent: nil
  has_one :purchase_order, dependent: nil

  validates :status, presence: true
  validates :status, inclusion: { in: Statuses::ALL }, allow_nil: true

  def final?
    status.in?(Statuses::FINAL)
  end
end
