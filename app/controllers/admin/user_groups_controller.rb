# frozen_string_literal: true

module Admin
  class UserGroupsController < Admin::ApplicationController
    before_action :set_user_group, only: %i[show edit update destroy]

    def index
      @user_groups = @store.user_groups.order(ranking: :desc)
    end

    def show
    end

    def new
      @user_group = UserGroup.new
    end

    def edit
      @store = nil
    end

    def create
      @user_group = UserGroup.new(create_params)
      if @user_group.save
        respond_to do |format|
          format.html { redirect_to admin_user_group_url(@user_group) }
          format.turbo_stream
        end
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @store = nil
      if @user_group.update(update_params)
        respond_to do |format|
          format.html { redirect_to admin_user_group_url(@user_group) }
          format.turbo_stream
        end
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @user_group.destroy
        flash.notice = t('.success')
        redirect_to admin_store_user_groups_url(@store)
      else
        flash.alert = t('.alert')
        redirect_to admin_user_group_url(@user_group)
      end
    end

    private

    def set_user_group
      @user_group = @store.user_groups.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end

    def create_params
      params.require(:user_group).permit(:name, :key, :ranking).merge(store: @store)
    end

    def update_params
      params.require(:user_group).permit(:name, :key, :ranking)
    end
  end
end
