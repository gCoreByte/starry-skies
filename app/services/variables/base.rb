# frozen_string_literal: true

module Variables
  class Base < Liquid::Drop
    attr_reader :record

    def initialize(record:)
      super()
      @record = record
    end

    def available_variables
      provides_without_self + variables
    end

    def variables
      raise NotImplementedError
    end

    delegate :provides_without_self, to: :based_on_service

    private

    def based_on_service
      @_based_on_service ||= BasedOns::BasedOn.new(record: record)
    end
  end
end
