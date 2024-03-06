# frozen_string_literal: true

RSpec.describe ProductCategories::Update do
  let!(:fingerprint) { create(:fingerprint) }
  let!(:product_category) { create(:product_category) }
  let!(:payload) do
    {
      name: name,
      key: key
    }
  end

  let(:name) { 'Product Name' }
  let(:key) { 'product_key' }

  subject { described_class.new(product_category: product_category, fingerprint: fingerprint, payload: payload) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.not_to change(ProductCategory, :count)
        expect(subject.product_category).to have_attributes(
          name: name,
          key: key,
          updated_by: fingerprint
        )
      end
    end
  end
end
