# frozen_string_literal: true

module ProductVersions
  class Destroy < ApplicationService
    attr_accessor :product_version, :fingerprint

    validates :product_version, :fingerprint, presence: true

    validate if: :product_version do
      errors.add(:base, :must_be_inactive) if product_version.active?
    end

    protected

    def perform
      product_version.product_prices.destroy_all
      product_version.product_prices.reload
      product_version.product_version_categories.destroy_all
      product_version.product_version_categories.reload
      product_version.destroy!
    end
  end
end
