# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_request_details
  around_action :set_locale
  before_action :set_current_user
  before_action :set_store
  before_action :set_current_store
  before_action :authenticate

  layout 'main'

  attr_reader :current_user

  private

  def set_locale(&)
    cookies[:locale] = 'en' unless cookies[:locale]
    I18n.with_locale(cookies[:locale], &)
  end

  def authenticate
    redirect_to sign_in_path unless @current_user
  end

  def set_current_user
    session_record = Session.find_by(id: cookies.signed[:session_token])
    return unless session_record

    Current.session = session_record
    @current_user ||= Current.admin_account # rubocop:disable Naming/MemoizedInstanceVariableName
  end

  def set_store
    unless current_user
      @store = nil
      return
    end

    Current.store = current_user.stores.find_by(id: cookies[:store_id])
    @store = Current.store
  end

  def set_current_store
    @current_store = @store || current_user&.stores&.find_by(id: cookies[:store_id])
  end

  def set_current_request_details
    Current.user_agent = request.user_agent
    Current.ip_address = request.ip
    @request = request
  end

  def fingerprint
    return @_fingerprint if defined?(@_fingerprint)

    @_fingerprint = Fingerprint.from_admin(@current_user, Current.ip_address, Current.user_agent)
  end
end
