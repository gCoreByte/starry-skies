# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :record, polymorphic: true

  validates :address, :country, presence: true
  # FIXME: add supported countries
  # validates :country, inclusion: { in: :countries }, allow_nil: true
  # FIXME: add postal code validation
  # validates :postal_code, format: { with: /.{1, 10}/ }, allow_nil: true
  validates :city, :state, length: { maximum: 255 }, allow_nil: true
  validates :address, length: { maximum: 1000 }, allow_nil: true
end
