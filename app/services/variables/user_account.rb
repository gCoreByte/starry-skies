# frozen_string_literal: true

module Variables
  class UserAccount < Variables::Base
    delegate :id, :email, to: :record

    def variables
      %w[id purchase_orders email]
    end

    def purchase_orders
      record.purchase_orders.order(:created_at).map do |purchase_order|
        Variables::VariableProvider.new(record: purchase_order)
      end
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
