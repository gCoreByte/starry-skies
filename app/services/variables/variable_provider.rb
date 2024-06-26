# frozen_string_literal: true

module Variables
  class VariableProvider
    class << self
      def new(record:)
        return unless record

        "Variables::#{record.class.name}".constantize.new(record: record)
      end
    end
  end
end
