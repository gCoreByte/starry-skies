# frozen_string_literal: true

RSpec.describe ProductVersionCategories::Create do
  let!(:store) { create(:store) }
  let!(:product_version) { create(:product_version, store: store) }
  let!(:product_category) { create(:product_category, store: store) }
  let!(:fingerprint) { create(:fingerprint) }

  subject do
    described_class.new(product_version: product_version, product_category: product_category, fingerprint: fingerprint)
  end

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(ProductVersionCategory, :count).from(0).to(1)
      end
    end

    context 'when mismatching store' do
      let!(:product_category) { create(:product_category) }

      it do
        expect { subject.save! }.to raise_error('Store mismatch')
      end
    end
  end
end
