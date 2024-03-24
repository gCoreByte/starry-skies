# frozen_string_literal: true

module BasedOns
  class Base
    include ActiveModel::Model
    include ActiveModel::Attributes

    attr_accessor :record

    validates :record, presence: true

    def provides
      raise NotImplementedError
    end

    def provides_without_self
      provides - [record.class.name.underscore]
    end
  end
end
