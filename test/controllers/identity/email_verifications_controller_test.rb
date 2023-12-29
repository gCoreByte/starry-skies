# frozen_string_literal: true

class Identity::EmailVerificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_account = sign_in_as(users(:lazaro_nixon))
    @admin_account.update! verified: false
  end

  test 'should send a verification email' do
    assert_enqueued_email_with AdminAccountMailer, :email_verification, params: { user: @admin_account } do
      post identity_email_verification_url
    end

    assert_redirected_to root_url
  end

  test 'should verify email' do
    sid = @admin_account.generate_token_for(:email_verification)

    get identity_email_verification_url(sid:, email: @admin_account.email)
    assert_redirected_to root_url
  end

  test 'should not verify email with expired token' do
    sid = @admin_account.generate_token_for(:email_verification)

    travel 3.days

    get identity_email_verification_url(sid:, email: @admin_account.email)

    assert_redirected_to edit_identity_email_url
    assert_equal 'That email verification link is invalid', flash[:alert]
  end
end
