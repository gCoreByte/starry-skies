# frozen_string_literal: true

module ProductCategories
  class Create < ProductCategories::Base
    attr_accessor :store

    validates :store, presence: true

    def product_category
      @_product_category ||= ProductCategory.new(
        store: store,
        created_by: fingerprint,
        updated_by: fingerprint
      ).tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end
  end
end
