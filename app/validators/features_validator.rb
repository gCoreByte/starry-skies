# frozen_string_literal: true

class FeaturesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, values)
    return record.errors.add(attribute, :invalid_type) unless values.is_a?(Array)
    return record.errors.add(attribute, :contains_not_unique_values) if values.uniq != values

    invalid_values = values.reject { |value| Features::ALL.include?(value) }
    return if invalid_values.empty?

    record.errors.add(attribute, :inclusion, value: values)
  end
end
