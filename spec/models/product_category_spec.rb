# frozen_string_literal: true

RSpec.describe ProductCategory do
  describe 'factory valid' do
    it { expect(build(described_class.model_name.singular)).to be_valid }
  end
end
