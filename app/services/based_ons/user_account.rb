# frozen_string_literal: true

module BasedOns
  class UserAccount < BasedOns::Base
    delegate :store, to: :record

    def provides
      %w[store user_account]
    end

    def user_account
      record
    end
  end
end
