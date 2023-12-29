# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  belongs_to :created_by, class_name: 'AdminAccount'

  validates :name, presence: true
  validates :name, length: { minimum: 3, maximum: 100 }, allow_nil: true
end
