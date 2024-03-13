# frozen_string_literal: true

module Products
  class Destroy < ApplicationService
    attr_accessor :product, :fingerprint

    validates :product, :fingerprint, presence: true

    validate if: :product do
      errors.add(:base, :cannot_have_active_versions) if product.product_version.present?
    end

    protected

    def perform
      product.product_versions.each do |product_version|
        ProductVersions::Destroy.new(product_version: product_version, fingerprint: fingerprint).save!
      end
      product.product_versions.reload
      product.destroy!
    end
  end
end
