# frozen_string_literal: true

RSpec.describe AdminAccounts::Destroy do
  let!(:admin_account) { create(:admin_account) }
  let!(:fingerprint) { create(:fingerprint, admin_account: admin_account) }

  subject { described_class.new(admin_account: admin_account, fingerprint: fingerprint) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(AdminAccount, :count).from(1).to(0)
      end
    end

    context 'when admin account has relationships' do
      context 'when relationship is admin' do
        let!(:admin_store_relationship) { create(:admin_store_relationship, :admin, admin_account: admin_account) }

        it do
          expect(subject).to validate_errors_on(:base).with_details(error: :cannot_have_any_admin_relationships)
        end
      end

      context 'when relationship is not admin' do
        let(:store) { create(:store, created_by: fingerprint) }
        let!(:admin_store_relationship) do
          create(:admin_store_relationship, :manager, admin_account: admin_account, store: store)
        end

        it do
          expect { subject.save! }.to change(AdminAccount, :count).from(1).to(0)
        end
      end
    end
  end
end
