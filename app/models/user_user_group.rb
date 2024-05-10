# frozen_string_literal: true

class UserUserGroup < ApplicationRecord
  belongs_to :store
  belongs_to :user_account
  belongs_to :user_group

  validate if: %i[user_account user_group] do
    validate_record_store(user_account)
    validate_record_store(user_group)
  end

  validates :user_group_id, uniqueness: { scope: :user_account_id }

  delegate :name, :key, :ranking, to: :user_group
end
