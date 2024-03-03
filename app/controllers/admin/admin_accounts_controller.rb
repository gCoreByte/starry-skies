# frozen_string_literal: true

module Admin
  class AdminAccountsController < Admin::ApplicationController
    before_action :set_admin_account

    def show
      render :show
    end

    def edit
      @service = AdminAccounts::Update.new(admin_account: @admin_account)
      render :edit
    end

    def update
      @service = AdminAccounts::Update.new(admin_account: @admin_account, payload: update_params)
      if @service.save
        redirect_to admin_admin_account_url(@admin_account)
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @admin_account.destroy!

      redirect_to '/home'
    end

    private

    def set_admin_account
      @admin_account = current_user
    end

    def update_params
      params.require(:admin_account).permit(:email, :password, :password_confirmation, :name)
    end
  end
end
