# frozen_string_literal: true

module ProductVersions
  class Create < ProductVersions::Base
    attr_accessor :product

    validates :product, presence: true

    delegate :store, to: :product

    def product_version
      @_product_version ||= ProductVersion.new(
        product: product,
        store: store,
        version: new_version,
        created_by: fingerprint,
        updated_by: fingerprint
      ).tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    private

    def new_version
      product.product_versions.maximum(:version).to_i + 1
    end
  end
end
