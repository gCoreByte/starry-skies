# frozen_string_literal: true

class AdminAccountMailer < ApplicationMailer
  def password_reset
    @admin_account = params[:admin_account]
    @signed_id = @admin_account.generate_token_for(:password_reset)

    mail to: @admin_account.email, subject: 'Reset your password'
  end

  def email_verification
    @admin_account = params[:admin_account]
    @signed_id = @admin_account.generate_token_for(:email_verification)

    mail to: @admin_account.email, subject: 'Verify your email'
  end
end
