# frozen_string_literal: true

module ProductVersionCategories
  class Create < ApplicationService
    attr_accessor :product_version, :product_category, :store, :fingerprint

    validates :product_version, :product_category, :store, :fingerprint, presence: true

    validate do
      validate_model(product_version_category, :base)
    end

    def product_version_category
      @_product_version_category ||= ProductVersionCategory.new(
        product_category: product_category,
        product_version: product_version,
        store: store,
        created_by: fingerprint
      )
    end

    protected

    def perform
      product_version_category.save!
    end
  end
end
