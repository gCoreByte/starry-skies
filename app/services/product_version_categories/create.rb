# frozen_string_literal: true

module ProductVersionCategories
  class Create < ApplicationService
    attr_accessor :product_version, :product_category, :fingerprint

    validates :product_version, :product_category, :fingerprint, presence: true

    validate do
      validate_model(product_version_category, :base)
    end

    def product_version_category
      @_product_version_category ||= ProductVersionCategory.new(
        product_category: product_category,
        product_version: product_version,
        created_by: fingerprint
      )
    end

    protected

    def perform
      product_version_category.save!
    end
  end
end
