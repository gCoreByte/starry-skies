# frozen_string_literal: true

module ProductVersions
  class Activate < ProductVersions::Base
    attr_accessor :product_version

    validate if: :product_version do
      errors.add(:base, :invalid_state) if product_version.active?
    end

    delegate :product, to: :product_version

    protected

    def perform
      previous_product_version&.deactivate!(fingerprint)
      product_version.activate!(fingerprint)
    end

    def previous_product_version
      @_previous_product_version ||= product.product_version
    end
  end
end
