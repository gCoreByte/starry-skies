# frozen_string_literal: true

RSpec.describe Variables::VariableProvider do
  record_types = %w[store product]

  record_types.each do |record_type|
    describe "#{record_type} has variable class" do
      klass = described_class.new(record: FactoryBot.create(record_type.to_sym)) # rubocop:disable FactoryBot/SyntaxMethods

      klass.available_variables.each do |variable|
        it "provides #{variable}" do
          expect { klass.public_send(variable) }.not_to raise_error
        end
      end
    end
  end
end
