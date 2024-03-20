# frozen_string_literal: true

module User
  class ApplicationController < ActionController::Base
    before_action :set_current_request_details
    before_action :set_store
    before_action :set_current_user

    layout 'main'

    private

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def set_store
      @store = Store.find_by!(url: request.base_url)
    end

    def session
      return @_session if defined?(@_session)

      session_cookie = cookies.signed[:user_session_token]
      @_session = UserSession.find_by(id: session_cookie, store: @store) if session_cookie
      return @_session if @_session

      @_session = UserSessions::Create.new(
        cookie: SecureRandom.hex(128),
        store: @store,
        fingerprint: fingerprint
      )
    end

    def set_current_user
      Current.session = session
      Current.user = session.user_account

      @current_user = session.user_account
    end

    def fingerprint
      return @_fingerprint if defined?(@_fingerprint)

      @_fingerprint = Fingerprint.from_user(@current_user, Current.ip_address, Current.user_agent)
    end
  end
end
