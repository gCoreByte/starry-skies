# frozen_string_literal: true

module Documentations
  class Variables
    RECORDS = %w[product_category product_price product product_version purchase_cart purchase_cart_item store].freeze

    def all
      RECORDS.sort.index_with do |record|
        ::Variables::VariableProvider.new(record: record.classify.constantize.new).available_variables.sort
      end
    end
  end
end
