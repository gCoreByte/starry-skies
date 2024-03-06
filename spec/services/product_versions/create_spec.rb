# frozen_string_literal: true

RSpec.describe ProductVersions::Create do
  let!(:store) { create(:store) }
  let!(:product) { create(:product, store: store) }
  let!(:product_version) { create(:product_version, product: product, version: 1) }
  let!(:fingerprint) { create(:fingerprint) }
  let!(:payload) do
    {
      description: 'New description',
      width: 1.0,
      length: 1.0,
      height: 1.0,
      weight: 1.0,
      size_unit: ProductVersion::SizeUnits::CM,
      weight_unit: ProductVersion::WeightUnits::KG
    }
  end

  subject { described_class.new(product: product, fingerprint: fingerprint, payload: payload) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(ProductVersion, :count).by(1)
        expect(subject.product_version).to have_attributes(
          **payload,
          version: 2
        )
      end
    end
  end
end
