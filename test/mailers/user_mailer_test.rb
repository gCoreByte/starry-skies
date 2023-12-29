require "test_helper"

class AdminAccountMailerTest < ActionMailer::TestCase
  setup do
    @admin_account = users(:lazaro_nixon)
  end

  test "password_reset" do
    mail = AdminAccountMailer.with(user: @admin_account).password_reset
    assert_equal "Reset your password", mail.subject
    assert_equal [@admin_account.email], mail.to
  end

  test "email_verification" do
    mail = AdminAccountMailer.with(user: @admin_account).email_verification
    assert_equal "Verify your email", mail.subject
    assert_equal [@admin_account.email], mail.to
  end
end
