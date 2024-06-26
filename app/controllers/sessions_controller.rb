# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create]

  before_action :set_session, only: :destroy

  def new
  end

  def create # rubocop:disable Metrics/AbcSize
    if (admin_account = AdminAccount.authenticate_by(email: params[:email], password: params[:password]))
      @session = admin_account.sessions.create!
      cookies.signed.permanent[:session_token] = { value: @session.id, httponly: true }

      redirect_to admin_dashboard_index_path
    else
      flash.alert = t('.alert') # FIXME: Localize
      redirect_to sign_in_path(email_hint: params[:email])
    end
  end

  def destroy
    @session.destroy
    redirect_to(root_path)
  end

  private

  def set_session
    @session = Current.admin_account.sessions.find(params[:id])
  end
end
