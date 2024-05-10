# frozen_string_literal: true

module Variables
  class ProductPrice < Variables::Base
    delegate :id, :price, to: :record

    def variables
      %w[id price]
    end

    def product
      Variables::VariableProvider.new(record: based_on_service.product)
    end

    def product_version
      Variables::VariableProvider.new(record: based_on_service.product_version)
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
