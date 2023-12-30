# frozen_string_literal: true

class Package < ApplicationRecord
  validates :name, :key, :features, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: MAX_PRICE }, allow_nil: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :key, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :features, features: true, allow_nil: true
end
