# frozen_string_literal: true

module UserAccounts
  class Create < ApplicationService
    ATTRIBUTES = %i[email password password_confirmation].freeze

    attr_accessor :store, :fingerprint
    attr_writer :payload

    delegate :user_session, to: :fingerprint

    validate if: :user_account do
      validate_model(user_account, :base, *ATTRIBUTES)
    end

    delegate(*ATTRIBUTES, to: :user_account)

    def payload
      @_payload ||= @payload || {}
    end

    def user_account
      @_user_account ||= UserAccount.new(
        store: store
      ).tap do |user_account|
        user_account.assign_attributes(payload.slice(*ATTRIBUTES))
      end
    end

    protected

    def perform
      user_account.save!
      user_session.update!(user_account: user_account)
    end
  end
end
