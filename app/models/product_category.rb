# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
end
