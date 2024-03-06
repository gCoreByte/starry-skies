# frozen_string_literal: true

module ProductCategories
  class Destroy < ApplicationService
    attr_accessor :product_category, :fingerprint

    validates :product_category, :fingerprint, presence: true

    validate if: :product_category do
      errors.add(:base, :cannot_be_in_use) if product_category.product_version_categories.any?
    end

    protected

    def perform
      product_category.product_version_categories.destroy_all
      product_category.product_version_categories.reload
      product_category.destroy!
    end
  end
end
