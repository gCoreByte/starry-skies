# frozen_string_literal: true

module BasedOns
  class BasedOn
    class << self
      def new(record:)
        "BasedOns::#{record.class.name}".constantize.new(record: record)
      end
    end
  end
end
