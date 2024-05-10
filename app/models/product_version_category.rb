# frozen_string_literal: true

class ProductVersionCategory < ApplicationRecord
  belongs_to :store
  belongs_to :product_category
  belongs_to :product_version
  belongs_to :created_by, class_name: 'Fingerprint'

  validate if: %i[product_category product_version] do
    validate_record_store(product_category)
    validate_record_store(product_version)
  end
end
