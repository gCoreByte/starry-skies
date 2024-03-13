# frozen_string_literal: true

class ProductVersionCategory < ApplicationRecord
  belongs_to :product_category
  belongs_to :product_version
  belongs_to :created_by, class_name: 'Fingerprint'

  validate if: %i[product_category product_version] do
    raise 'Store mismatch' if product_category.store_id != product_version.store_id
  end
end
