# frozen_string_literal: true

module Admin
  class ApplicationController < ActionController::Base
    before_action :set_current_request_details
    before_action :authenticate

    private

    def authenticate
      session_record = Session.find_by(id: cookies.signed[:session_token])
      if session_record
        Current.session = session_record
      else
        redirect_to sign_in_path
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def current_user
      Current.admin_account
    end

    def fingerprint
      @_fingerprint ||= Fingerprint.from_user(current_user, Current.ip_address, Current.user_agent)
    end
  end
end
