# frozen_string_literal: true

module BasedOns
  class Store < BasedOns::Base
    def provides
      %w[store]
    end

    def store
      record
    end
  end
end
