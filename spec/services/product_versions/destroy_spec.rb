# frozen_string_literal: true

RSpec.describe ProductVersions::Destroy do
  let!(:fingerprint) { create(:fingerprint) }
  let!(:product_version) { create(:product_version) }

  subject { described_class.new(product_version: product_version, fingerprint: fingerprint) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(ProductVersion, :count).from(1).to(0)
      end
    end

    context 'when version is active' do
      let!(:product_version) { create(:product_version, :active) }

      it do
        expect(subject).to validate_errors_on(:base).with_details(error: :must_be_inactive)
      end
    end
  end
end
