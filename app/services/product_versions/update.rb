# frozen_string_literal: true

module ProductVersions
  class Update < ProductVersions::Base
    attr_writer :product_version

    validate if: :product_version do
      errors.add(:base, :must_be_inactive) if product_version.active?
    end

    def product_version
      @_product_version ||= @product_version.tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      return unless product_version.changed?

      product_version.updated_by = fingerprint
      super
    end
  end
end
