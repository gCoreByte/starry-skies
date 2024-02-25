# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user_agent, :ip_address
  attribute :store

  delegate :admin_account, to: :session, allow_nil: true
end
