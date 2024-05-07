# frozen_string_literal: true

module Variables
  class ProductCategory < Variables::Base
    def variables
      %w[id name products]
    end

    delegate :id, :name, to: :record

    def products
      record.products.active.map do |product|
        Variables::VariableProvider.new(record: product)
      end
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
