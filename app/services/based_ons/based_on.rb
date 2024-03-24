# frozen_string_literal: true

module BasedOns
  class BasedOn
    class << self
      POSSIBLE_BASED_ONS = %w[product store].freeze

      def new(record:)
        "BasedOns::#{record.class.name}".constantize.new(record: record)
      end

      def possible_based_ons
        POSSIBLE_BASED_ONS
      end
    end
  end
end
