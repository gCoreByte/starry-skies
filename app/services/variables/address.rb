# frozen_string_literal: true

module Variables
  class Address < Variables::Base
    delegate :id, :address, :country, :postal_code, :state, :city, to: :record

    def variables
      %w[id address country postal_code state city]
    end

    def store
      Variables::VariableProvider.new(record: based_on_service.store)
    end
  end
end
