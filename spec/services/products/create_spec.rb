# frozen_string_literal: true

RSpec.describe Products::Create do
  let!(:store) { create(:store) }
  let!(:fingerprint) { create(:fingerprint) }
  let!(:payload) do
    {
      key: key
    }
  end

  let(:key) { 'product_key' }

  subject { described_class.new(store: store, fingerprint: fingerprint, payload: payload) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(Product, :count).by(1)
        expect(subject.product).to have_attributes(
          key: key,
          created_by: fingerprint,
          updated_by: fingerprint
        )
      end
    end
  end
end
