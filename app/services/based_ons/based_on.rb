# frozen_string_literal: true

module BasedOns
  class BasedOn
    class << self
      POSSIBLE_BASED_ONS = %w[product store product_version product_category purchase_cart purchase_cart_item
                              user_account purchase_order address].freeze

      def new(record:)
        "BasedOns::#{record.class.name}".constantize.new(record: record)
      end

      def possible_based_ons
        POSSIBLE_BASED_ONS
      end
    end
  end
end
