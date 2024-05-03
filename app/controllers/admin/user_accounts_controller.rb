# frozen_string_literal: true

module Admin
  class UserAccountsController < Admin::ApplicationController
    before_action :set_user_account, only: %i[show]

    def index
      @user_accounts = @store.user_accounts.order(created_at: :desc)
    end

    def show
      @user_user_groups = @user_account.user_user_groups.joins(:user_group).order(ranking: :desc)
    end

    private

    def set_user_account
      @user_account = @store.user_accounts.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
