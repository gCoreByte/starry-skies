# frozen_string_literal: true

module Identity
  class PasswordResetsController < ApplicationController
    skip_before_action :authenticate

    before_action :set_admin_account, only: %i[edit update]

    def new
    end

    def edit
    end

    def create
      if (@admin_account = AdminAccount.find_by(email: params[:email], verified: true))
        send_password_reset_email
        redirect_to sign_in_path
      else
        redirect_to new_identity_password_reset_path
      end
    end

    def update
      if @admin_account.update(admin_account_params)
        redirect_to sign_in_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_admin_account
      @admin_account = AdminAccount.find_by_token_for!(:password_reset, params[:sid])
    rescue StandardError
      redirect_to new_identity_password_reset_path
    end

    def admin_account_params
      params.permit(:password, :password_confirmation)
    end

    def send_password_reset_email
      AdminAccountMailer.with(admin_account: @admin_account).password_reset.deliver_later
    end
  end
end
