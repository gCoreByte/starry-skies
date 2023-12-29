# frozen_string_literal: true

class Identity::EmailsController < ApplicationController
  before_action :set_admin_account

  def edit; end

  def update
    if @admin_account.update(admin_account_params)
      redirect_to_root
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_admin_account
    @admin_account = Current.admin_account
  end

  def admin_account_params
    params.permit(:email, :password_challenge).with_defaults(password_challenge: '')
  end

  def redirect_to_root
    return unless @admin_account.email_previously_changed?

    resend_email_verification
    redirect_to root_path
  end

  def resend_email_verification
    AdminAccountMailer.with(admin_account: @admin_account).email_verification.deliver_later
  end
end
