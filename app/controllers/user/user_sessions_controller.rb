# frozen_string_literal: true

module User
  class UserSessionsController < User::ApplicationController
    def new
    end

    def create
      user_account = UserAccount.authenticate_by(create_params)
      if user_account
        @service = UserSessions::Create.new(store: @store, user_account: user_account, fingerprint: fingerprint)
        @service.save!
      else
        flash.alert = 'Invalid email or password'
        redirect_to new_user_user_session_path
      end
    end

    def destroy
      session.destroy!
      cookies.signed[:user_session_token].delete
      redirect_to new_user_user_session_path
    end
  end
end
