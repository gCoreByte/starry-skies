# frozen_string_literal: true

class Identity::EmailVerificationsController < ApplicationController
  skip_before_action :authenticate, only: :show

  before_action :set_admin_account, only: :show

  def show
    @admin_account.update! verified: true
    redirect_to root_path
  end

  def create
    send_email_verification
    redirect_to root_path
  end

  private

  def set_admin_account
    @admin_account = AdminAccount.find_by_token_for!(:email_verification, params[:sid])
  rescue StandardError
    redirect_to edit_identity_email_path
  end

  def send_email_verification
    AdminAccountMailer.with(admin_account: Current.admin_account).email_verification.deliver_later
  end
end
