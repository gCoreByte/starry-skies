# frozen_string_literal: true

class HashValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, :invalid_type) unless value.is_a?(Hash)
  end
end
