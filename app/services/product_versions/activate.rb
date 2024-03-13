# frozen_string_literal: true

module ProductVersions
  class Activate < ProductVersions::Base
    attr_accessor :product_version

    validate if: :product_version do
      errors.add(:base, :invalid_state) if product_version.active?
    end

    protected

    def perform
      product_version.activate!(fingerprint)
    end
  end
end
