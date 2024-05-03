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

    def render_404 # rubocop:disable Naming/VariableNumber
      respond_to do |format|
        format.html { render file: Rails.public_path.join('404.html'), layout: false, status: :not_found }
        format.xml  { head :not_found }
        format.any  { head :not_found }
      end
    end

    def permit_association(name, params)
      return unless params.key?(name)

      model_name = name.to_s.delete_suffix('_id')
      klass = model_name.classify.constantize
      id = params.delete(name)
      params.merge!(name.to_sym => klass.find_by(id: id, store: @store))
    end

    def authenticate
      return if @current_user

      cookies.delete(:store_id)
      redirect_to sign_in_path
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

    def set_current_request_details
      Current.user_agent = request.user_agent
      Current.ip_address = request.ip
    end

    def fingerprint
      return @_fingerprint if defined?(@_fingerprint)

      @_fingerprint = Fingerprint.from_admin(@current_user, Current.ip_address, Current.user_agent)
    end
  end
end
