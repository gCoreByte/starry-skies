# frozen_string_literal: true

RSpec.describe AdminAccounts::Update do
  let!(:admin_account) { create(:admin_account) }
  let!(:fingerprint) { create(:fingerprint, admin_account: admin_account) }
  let!(:payload) do
    {
      email: email,
      name: name,
      password: password,
      password_confirmation: password_confirmation
    }
  end

  let(:email) { 'hey@example.com' }
  let(:name) { 'yippie' }
  let(:password) { '123password123' }
  let(:password_confirmation) { password }

  subject { described_class.new(payload: payload, admin_account: admin_account, fingerprint: fingerprint) }

  describe '#save!' do
    context 'when successful' do
      it do
        expect { subject.save! }.to change(admin_account, :password)
        expect(admin_account).to have_attributes(
          email: email,
          name: name
        )
      end
    end

    context 'when admin account has no changes' do
      let(:payload) { {} }

      it do
        expect { subject.save! }.not_to(change { admin_account })
      end
    end

    context 'when password doesnt match' do
      let(:password_confirmation) { '' }

      it do
        expect(subject).to validate_errors_on(:password_confirmation).with_details(error: :confirmation)
      end
    end
  end
end
