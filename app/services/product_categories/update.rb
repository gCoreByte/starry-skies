# frozen_string_literal: true

module ProductCategories
  class Update < ProductCategories::Base
    attr_writer :product_category

    def product_category
      @_product_category ||= @product_category.tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      return unless product_category.changed?

      product_category.updated_by = fingerprint
      super
    end
  end
end
