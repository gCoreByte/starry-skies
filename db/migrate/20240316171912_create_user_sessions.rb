# frozen_string_literal: true

class CreateUserSessions < ActiveRecord::Migration[7.1]
  def change
    create_table :user_sessions, id: :uuid do |t|
      t.string :cookie, null: false
      t.datetime :expires_at, null: false
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :user_account, null: true, foreign_key: true, type: :uuid, index: true
      t.timestamps

      t.index %i[store_id cookie], unique: true
    end
  end
end
