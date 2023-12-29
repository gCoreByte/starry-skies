# frozen_string_literal: true

module Mixins
  module ValidateModel
    def validate_model(model, *attributes)
      return true if model.valid?

      attributes.each do |attribute|
        attribute_errors = model.errors.where(attribute)
        attribute_errors.each do |error|
          errors.add(attribute, error.type, **error.options)
        end
      end
      false
    end
  end
end
