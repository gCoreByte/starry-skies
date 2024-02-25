# frozen_string_literal: true

module Admin
  class ApplicationController < ActionController::Base
    before_action :set_current_request_details
    before_action :set_current_user
    before_action :set_store
    before_action :authenticate

    layout 'main'

    attr_reader :current_user

    private

    def authenticate
      return if @current_user

      cookies[:store_id].delete
      redirect_to sign_in_path
    end

    def set_current_user
      session_record = Session.find_by(id: cookies.signed[:session_token])
      return unless session_record

      Current.session = session_record
      @current_user ||= Current.admin_account # rubocop:disable Naming/MemoizedInstanceVariableName
    end

    def set_store
      Current.store = current_user.stores.find_by(id: cookies[:store_id])
      @store = Current.store
    end

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def fingerprint
      return @_fingerprint if defined?(@_fingerprint)

      @_fingerprint = Fingerprint.from_user(@current_user, Current.ip_address, Current.user_agent)
    end
  end
end
