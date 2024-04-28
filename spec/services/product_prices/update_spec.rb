# frozen_string_literal: true

RSpec.describe ProductPrices::Update do
  let!(:fingerprint) { create(:fingerprint) }
  let!(:product_price) { create(:product_price) }
  let!(:payload) do
    {
      locale: 'et',
      currency: 'EUR',
      price: 50.0
    }
  end

  subject { described_class.new(product_price: product_price, fingerprint: fingerprint, payload: payload) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.not_to change(ProductPrice, :count)
        expect(subject.product_price).to have_attributes(
          locale: 'et',
          currency: 'EUR',
          price: 50.0,
          updated_by: fingerprint
        )
      end
    end
  end
end
