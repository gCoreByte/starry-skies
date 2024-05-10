# frozen_string_literal: true

module User
  class UserAccountsController < User::ApplicationController
    def new
      @service = UserAccounts::Create.new(store: @store, fingerprint: fingerprint)
      @user_account = @service.user_account
    end

    def create
      @service = UserAccounts::Create.new(store: @store, payload: create_params, fingerprint: fingerprint)
      @user_account = @service.user_account
      if @service.save
        redirect_to success_user_accounts_path
      else
        render :new
      end
    end

    def success
    end

    private

    def create_params
      params.require(:user_account).permit(:email, :password, :password_confirmation)
    end
  end
end
