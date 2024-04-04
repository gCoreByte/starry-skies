# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  class << self
    def nullify_attributes(*attrs)
      attrs.each do |attribute|
        define_method("#{attribute}=") do |value|
          super(value.presence)
        end
      end
    end
  end

  def validate_record_store(record)
    raise 'Store mismatch' if record.store_id != store_id
  end
end
