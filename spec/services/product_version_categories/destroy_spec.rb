# frozen_string_literal: true

RSpec.describe ProductVersionCategories::Destroy do
  let!(:product_version_category) { create(:product_version_category) }
  let!(:fingerprint) { create(:fingerprint) }

  subject do
    described_class.new(product_version_category: product_version_category, fingerprint: fingerprint)
  end

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(ProductVersionCategory, :count).from(1).to(0)
      end
    end
  end
end
