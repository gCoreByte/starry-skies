# frozen_string_literal: true

class ProductPrice < ApplicationRecord
  belongs_to :store
  belongs_to :created_by, class_name: 'Fingerprint'
  belongs_to :product_version
end
