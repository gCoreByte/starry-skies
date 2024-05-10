# frozen_string_literal: true

module User
  class UserSessionsController < User::ApplicationController
    def new
      redirect_to user_root_path if session.user_account
    end

    def create
      redirect_to user_root_path if session.user_account

      user_account = UserAccount.authenticate_by(create_params)
      if user_account
        session.update!(user_account: user_account)
        redirect_to user_root_path
      else
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.destroy!
      cookies.signed[:user_session_token].delete
      redirect_to user_root_path
    end

    private

    def create_params
      params.require(:user_session).permit(:email, :password)
    end
  end
end
