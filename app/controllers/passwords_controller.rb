# frozen_string_literal: true

class PasswordsController < ApplicationController
  before_action :set_admin_account

  def edit; end

  def update
    if @admin_account.update(admin_account_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_admin_account
    @admin_account = Current.admin_account
  end

  def admin_account_params
    params.permit(:password, :password_confirmation, :password_challenge).with_defaults(password_challenge: '')
  end
end
