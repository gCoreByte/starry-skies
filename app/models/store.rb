# frozen_string_literal: true

class Store < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
  validates :url, length: { maximum: 100 }, allow_nil: true
end
