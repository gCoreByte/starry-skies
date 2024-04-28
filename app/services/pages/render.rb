# frozen_string_literal: true

module Pages
  class Render
    def initialize(page:, record:)
      @page = page
      @record = record
    end

    def render
      Liquid::Template.parse(@page.content).render(variables)
    end

    private

    def variables
      variables = { @record.class.name.underscore => variable_provider }
      variable_provider.provides_without_self.each do |key|
        variables[key] = variable_provider.public_send(key)
      end

      variables
    end

    def variable_provider
      @_variable_provider ||= Variables::VariableProvider.new(record: @record)
    end
  end
end
