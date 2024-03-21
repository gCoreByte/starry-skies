# frozen_string_literal: true

module BasedOns
  class Store < BasedOns::Base
    PROVIDES = %w[store].freeze

    def provides
      PROVIDES
    end

    def store
      record
    end
  end
end
