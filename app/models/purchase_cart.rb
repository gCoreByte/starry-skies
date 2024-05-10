# frozen_string_literal: true

class PurchaseCart < ApplicationRecord
  EXPIRY_PERIOD = 24.hours

  module Statuses
    CREATED = 'created' # initial status
    BOOKED = 'booked' # during paying
    BILLED = 'billed' # paid
    EXPIRED = 'expired'
    ALL = [CREATED, BOOKED, BILLED, EXPIRED].freeze
    FINAL = [BILLED, EXPIRED].freeze
  end

  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :updated_by, class_name: 'Fingerprint'
  belongs_to :user_account, optional: true
  belongs_to :user_session, optional: true

  has_many :purchase_cart_items, dependent: nil
  has_one :purchase_order, dependent: nil

  validates :status, presence: true
  validates :status, inclusion: { in: Statuses::ALL }, allow_nil: true

  scope :active, -> { where.not(status: Statuses::FINAL) }

  def final?
    status.in?(Statuses::FINAL)
  end
end
