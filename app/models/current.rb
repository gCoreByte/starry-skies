# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :session
  attribute :user_agent, :ip_address
  attribute :store
  attribute :user_session

  delegate :admin_account, to: :session, allow_nil: true
  delegate :user_account, to: :user_session, allow_nil: true
end
