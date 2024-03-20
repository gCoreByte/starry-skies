# frozen_string_literal: true

module User
  class UserAccountsController < User::ApplicationController
    def new
      @user_account = UserAccount.new(store: @store)
    end

    def create
      @service = UserAccounts::Create.new(store: @store, payload: create_params, fingerprint: fingerprint)
      @user_account = @service.user_account
      if service.save
        redirect_to root_path
      else
        render :new
      end
    end
  end
end
