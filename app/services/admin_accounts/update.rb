# frozen_string_literal: true

module AdminAccounts
  class Update < ApplicationService
    ATTRIBUTES = %i[email name password password_confirmation].freeze

    attr_writer :admin_account, :payload
    attr_accessor :fingerprint

    validates :admin_account, :fingerprint, presence: true

    validate if: :admin_account do
      validate_model(admin_account, :base, *ATTRIBUTES)
    end

    delegate(*ATTRIBUTES, to: :admin_account)

    def admin_account
      @_admin_account ||= @admin_account.tap do |admin_account|
        admin_account.assign_attributes(
          payload.slice(*ATTRIBUTES)
        )
      end
    end

    def payload
      @_payload ||= @payload || {}
    end

    protected

    def perform
      return unless admin_account.changed?

      admin_account.save!
    end
  end
end
