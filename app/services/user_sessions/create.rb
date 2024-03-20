# frozen_string_literal: true

module UserSessions
  class Create < ApplicationService
    attribute :expires_at, :datetime, default: -> { UserSession::EXPIRY_PERIOD.from_now }
    attr_accessor :cookie, :store, :user_account, :fingerprint

    validate if: :user_session do
      validate_model(user_session, :base, :cookie, :expires_at)
    end

    def user_session
      @_user_session ||= UserSession.new(
        store: store,
        user_account: user_account,
        cookie: cookie,
        expires_at: expires_at
      )
    end

    protected

    def perform
      user_session.save!
    end
  end
end
