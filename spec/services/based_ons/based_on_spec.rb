# frozen_string_literal: true

RSpec.describe BasedOns::BasedOn do
  record_types = %w[store product]

  record_types.each do |record_type|
    describe "#{record_type} has based_on class" do
      klass = described_class.new(record: record_type.classify.constantize.new)

      klass.provides.each do |provide|
        it "provides #{provide}" do
          expect { klass.public_send(provide) }.not_to raise_error
        end
      end
    end
  end
end
