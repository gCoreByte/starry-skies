# frozen_string_literal: true

module Variables
  class ProductVersion < Variables::Base
    delegate :price, to: :record

    def variables
      %w[price]
    end
  end
end
