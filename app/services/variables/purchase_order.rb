# frozen_string_literal: true

module Variables
  class PurchaseOrder < Variables::Base
    delegate :id, :status, :first_name, :surname, :phone_number, to: :record

    def variables
      %w[id status first_name surname phone_number]
    end

    def purchase_cart
      Variables::VariableProvider.new(record: based_on_service.purchase_cart)
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end

    def address
      Variables::VariableProvider.new(record: based_on_service.address)
    end
  end
end
