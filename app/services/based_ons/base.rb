# frozen_string_literal: true

module BasedOns
  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes

    attr_accessor :record

    validates :record, presence: true

    def provides(record)
      raise NotImplementedError
    end
  end
end
