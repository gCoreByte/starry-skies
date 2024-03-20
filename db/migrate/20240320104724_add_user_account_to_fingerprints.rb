# frozen_string_literal: true

class AddUserAccountToFingerprints < ActiveRecord::Migration[7.1]
  def change
    change_table :fingerprints, bulk: true do |t|
      t.references :user_session, null: true, foreign_key: true, type: :uuid, index: true
      t.references :user_account, null: true, foreign_key: true, type: :uuid, index: true
    end
  end
end
