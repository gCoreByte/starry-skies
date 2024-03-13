# frozen_string_literal: true

RSpec.describe Products::Destroy do
  let!(:fingerprint) { create(:fingerprint) }
  let!(:product) { create(:product) }

  before do
    create(:product_version, product: product)
  end

  subject { described_class.new(product: product, fingerprint: fingerprint) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(Product, :count).by(-1).and change(ProductVersion, :count).by(-1)
      end
    end

    context 'when product has active versions' do
      let!(:active_product_version) { create(:product_version, :active, product: product) }

      it do
        expect(subject).to validate_errors_on(:base).with_details(error: :cannot_have_active_versions)
      end
    end
  end
end
