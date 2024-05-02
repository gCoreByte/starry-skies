# frozen_string_literal: true

module User
  class ApplicationController < ActionController::Base
    around_action :set_locale
    before_action :set_current_request_details
    before_action :set_store
    before_action :set_current_user
    before_action :set_purchase_cart

    layout nil

    private

    def set_locale(&)
      cookies[:locale] = 'en' unless cookies[:locale]
      I18n.with_locale(cookies[:locale], &)
    end

    def render_404 # rubocop:disable Naming/VariableNumber
      respond_to do |format|
        format.html { render file: Rails.public_path.join('404.html'), layout: false, status: :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def set_store
      return redirect_to root_path if request.subdomain.blank?

      @store = Store.find_by(url: request.subdomain)
      render_404 unless @store
    end

    def session
      return @_session if defined?(@_session)

      session_cookie = cookies.signed[:user_session_token]
      @_session = UserSession.find_by(id: session_cookie, store: @store) if session_cookie
      return @_session if @_session

      cookie = SecureRandom.hex(128)
      cookies.signed[:user_session_token] = cookie
      @_session = UserSessions::Create.new(
        cookie: cookie,
        store: @store
      )
    end

    def set_current_user
      Current.user_session = session

      @current_user = session.user_account
    end

    def set_purchase_cart
      @purchase_cart =
        @store.purchase_carts.active.find_by(user_account: @current_user) ||
        @store.purchase_carts.active.find_by(user_session: Current.user_session)
    end

    def fingerprint
      return @_fingerprint if defined?(@_fingerprint)

      @_fingerprint = Fingerprint.from_user(session, Current.ip_address, Current.user_agent)
    end
  end
end
