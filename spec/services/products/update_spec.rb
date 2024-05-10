# frozen_string_literal: true

RSpec.describe Products::Update do
  let!(:fingerprint) { create(:fingerprint) }
  let!(:product) { create(:product) }
  let!(:payload) do
    {
      key: key
    }
  end

  let(:key) { 'product_key' }

  subject { described_class.new(product: product, fingerprint: fingerprint, payload: payload) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.not_to change(Product, :count)
        expect(subject.product).to have_attributes(
          key: key,
          updated_by: fingerprint
        )
      end
    end
  end
end
