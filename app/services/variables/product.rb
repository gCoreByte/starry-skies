# frozen_string_literal: true

module Variables
  class Product < Variables::Base
    def variables
      %w[name key active? description width length height weight size_unit weight_unit title]
    end

    delegate :name, :key, :active?, :title, to: :record

    def description
      record.product_version&.description
    end

    def width
      record.product_version&.width
    end

    def length
      record.product_version&.length
    end

    def height
      record.product_version&.height
    end

    def weight
      record.product_version&.weight
    end

    def size_unit
      record.product_version&.size_unit
    end

    def weight_unit
      record.product_version&.weight_unit
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end

    def product_version
      Variables::VariableProvider.new(record: based_on_service.product_version)
    end
  end
end
