# frozen_string_literal: true

module BasedOns
  class Address < BasedOns::Base
    delegate :store, to: :record

    def provides
      %w[store address]
    end

    def address
      record
    end
  end
end
