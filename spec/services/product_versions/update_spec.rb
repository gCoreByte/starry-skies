# frozen_string_literal: true

RSpec.describe ProductVersions::Update do
  let!(:store) { create(:store) }
  let!(:product) { create(:product, store: store) }
  let!(:product_version) { create(:product_version, product: product) }
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

  subject { described_class.new(product_version: product_version, fingerprint: fingerprint, payload: payload) }

  describe '#save!' do
    context 'when successful' do
      it do
        subject.save!
        expect(subject.product_version).to have_attributes(
          payload
        )
      end
    end

    context 'when version is active' do
      let!(:product_version) { create(:product_version, :active, product: product) }

      it do
        expect(subject).to validate_errors_on(:base).with_details(error: :must_be_inactive)
      end
    end
  end
end
