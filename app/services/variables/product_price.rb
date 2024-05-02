# frozen_string_literal: true

module Variables
  class ProductVersion < Variables::Base
    delegate :id, :price, to: :record

    def variables
      %w[id price]
    end
  end
end
