# frozen_string_literal: true

RSpec.describe Variables::VariableProvider do
  record_types = %w[store product product_version product_price product_category purchase_cart purchase_cart_item]

  record_types.each do |record_type|
    describe "#{record_type} has variable class" do
      klass = described_class.new(record: FactoryBot.build(record_type.to_sym)) # rubocop:disable FactoryBot/SyntaxMethods

      klass.available_variables.each do |variable|
        it "and provides #{variable}" do
          expect(klass).to respond_to(variable)
          expect { klass.public_send(variable) }.not_to raise_error
        end
      end
    end
  end
end
