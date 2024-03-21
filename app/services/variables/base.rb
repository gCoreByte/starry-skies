# frozen_string_literal: true

module Variables
  class Base < Liquid::Drop
    attr_reader :record

    def initialize(record:)
      super()
      @record = record
    end
  end
end
