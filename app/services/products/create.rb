# frozen_string_literal: true

module Products
  class Create < Products::Base
    attr_accessor :store

    def product
      @_product ||= Product.new(
        store: store,
        created_by: fingerprint,
        updated_by: fingerprint
      ).tap do |o|
        o.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end
  end
end
