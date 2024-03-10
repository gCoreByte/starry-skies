# frozen_string_literal: true

module ProductVersions
  class Deactivate < ProductVersions::Base
    attr_accessor :product_version

    validate if: :product_version do
      errors.add(:base, :invalid_state) unless product_version.active?
    end

    protected

    def perform
      product_version.deactivate!(fingerprint)
    end
  end
end
