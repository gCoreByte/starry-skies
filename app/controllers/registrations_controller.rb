# frozen_string_literal: true

class RegistrationsController < ApplicationController
  skip_before_action :authenticate

  def new
    @admin_account = AdminAccount.new
  end

  def create
    @admin_account = AdminAccount.new(admin_account_params)

    if @admin_account.save
      session_record = @admin_account.sessions.create!
      cookies.signed.permanent[:session_token] = { value: session_record.id, httponly: true }

      send_email_verification
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def admin_account_params
    params.permit(:email, :name, :password, :password_confirmation)
  end

  def send_email_verification
    AdminAccountMailer.with(admin_account: @admin_account).email_verification.deliver_later
  end
end
