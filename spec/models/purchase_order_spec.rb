# frozen_string_literal: true

RSpec.describe PurchaseOrder do
  describe 'factory valid' do
    it { expect(build(described_class.model_name.singular)).to be_valid }
  end
end