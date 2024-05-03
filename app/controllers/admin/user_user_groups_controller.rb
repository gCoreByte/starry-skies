# frozen_string_literal: true

module Admin
  class UserUserGroupsController < Admin::ApplicationController
    before_action :set_user_account, only: %i[new create]
    before_action :set_user_user_group, only: %i[destroy]

    def new
      @user_user_group = UserUserGroup.new(user_account: @user_account)
    end

    def create
      @user_user_group = UserUserGroup.new(create_params)
      if @user_user_group.save
        respond_to do |format|
          format.html { redirect_to admin_user_account_url(@user_account) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      if @user_user_group.destroy
        flash.notice = 'User group was successfully removed.'
      else
        flash.alert = 'User group could not be removed.'
      end
      redirect_to admin_user_account_url(@user_account)
    end

    private

    def create_params
      params.require(:user_user_group).permit(
        :user_group_id
      ).merge!(
        user_account: @user_account, store: @store
      ) do |params|
        permit_association(:user_group_id, params)
      end
    end

    def set_user_account
      @user_account = @store.user_accounts.find(params[:user_account_id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def set_user_user_group
      @user_user_group = @store.user_user_groups.find(params[:id])
      @user_account = @user_user_group.user_account
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
end
