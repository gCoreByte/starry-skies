# frozen_string_literal: true

module Documentations
  class Variables
    RECORDS = BasedOns::BasedOn.possible_based_ons

    def all
      RECORDS.sort.index_with do |record|
        ::Variables::VariableProvider.new(record: record.classify.constantize.new).available_variables.sort
      end
    end
  end
end
