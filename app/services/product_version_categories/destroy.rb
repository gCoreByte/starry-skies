# frozen_string_literal: true

module ProductVersionCategories
  class Destroy < ApplicationService
    attr_accessor :product_version_category, :fingerprint

    validates :product_version_category, :fingerprint, presence: true

    protected

    def perform
      product_version_category.destroy!
    end
  end
end
