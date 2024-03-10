# frozen_string_literal: true

RSpec.describe ProductPrices::Destroy do
  let!(:product_price) { create(:product_price) }
  let!(:fingerprint) { create(:fingerprint) }

  subject do
    described_class.new(product_price: product_price, fingerprint: fingerprint)
  end

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(ProductPrice, :count).from(1).to(0)
      end
    end
  end
end
