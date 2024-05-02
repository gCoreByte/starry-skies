# frozen_string_literal: true

module Pages
  class Render
    def initialize(page:, record:, variables: {})
      @page = page
      @record = record
      @variables = variables
    end

    def render
      Liquid::Template.parse(@page.content).render(variables)
    end

    private

    def variables
      variables = { @record.class.name.underscore => variable_provider }.merge(existing_variables)
      variable_provider.provides_without_self.each do |key|
        variables[key] = variable_provider.public_send(key)
      end

      variables
    end

    def existing_variables
      @variables.transform_values do |value|
        Variables::VariableProvider.new(record: value)
      end
    end

    def variable_provider
      @_variable_provider ||= Variables::VariableProvider.new(record: @record)
    end
  end
end
