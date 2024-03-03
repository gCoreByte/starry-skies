# frozen_string_literal: true

module AdminAccounts
  class Update < ApplicationService
    ATTRIBUTES = %i[email name password password_confirmation].freeze

    attr_writer :admin_account, :payload

    validates :admin_account, presence: true

    validate if: :admin_account do
      validate_model(admin_account, :base, *ATTRIBUTES)
    end

    def admin_account
      @_admin_account ||= @admin_account.tap do |admin_account|
        admin_account.assign_attributes(
          payload.slice(*ATTRIBUTES)
        )
      end
    end

    protected

    def perform
      return unless admin_account.changed?

      admin_account.save!
    end
  end
end
