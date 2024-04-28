# frozen_string_literal: true

RSpec.describe ProductPrices::Create do
  let!(:store) { create(:store) }
  let!(:fingerprint) { create(:fingerprint) }
  let!(:product_version) { create(:product_version, store: store) }
  let!(:payload) do
    {
      locale: 'et',
      currency: 'EUR',
      price: 105.13
    }
  end

  subject { described_class.new(product_version: product_version, payload: payload, fingerprint: fingerprint) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(ProductPrice, :count).from(0).to(1)
        expect(subject.product_price).to have_attributes(
          locale: 'et',
          currency: 'EUR',
          price: 105.13
        )
      end
    end
  end
end
