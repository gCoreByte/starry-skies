# frozen_string_literal: true

RSpec.describe ProductCategories::Destroy do
  let!(:store) { create(:store) }
  let!(:product_category) { create(:product_category, store: store) }
  let!(:fingerprint) { create(:fingerprint) }

  subject { described_class.new(product_category: product_category, fingerprint: fingerprint) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(ProductCategory, :count).from(1).to(0)
      end
    end

    context 'when in use' do
      let!(:product_version_category) { create(:product_version_category, product_category: product_category) }

      it do
        expect(subject).to validate_errors_on(:base).with_details(error: :cannot_be_in_use)
      end
    end
  end
end
