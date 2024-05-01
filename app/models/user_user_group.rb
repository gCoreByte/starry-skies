# frozen_string_literal: true

class UserGroup < ApplicationRecord
  belongs_to :store
  belongs_to :user_account
  belongs_to :user_group

  validate do
    validate_record_store(user_account)
    validate_record_store(user_group)
  end
end
