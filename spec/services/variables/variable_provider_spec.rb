# frozen_string_literal: true

RSpec.describe Variables::VariableProvider do
  record_types = %w[store product]

  record_types.each do |record_type|
    describe "#{record_type} has variable class" do
      klass = described_class.new(record: record_type.classify.constantize.new)

      klass.variables.each do |variable|
        it variable do
          expect { klass.public_send(variable) }.not_to raise_error
        end
      end
    end
  end
end
