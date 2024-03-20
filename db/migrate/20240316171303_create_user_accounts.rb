# frozen_string_literal: true

class CreateUserAccounts < ActiveRecord::Migration[7.1]
  def change
    create_table :user_accounts, id: :uuid do |t|
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.string :email, null: false
      t.string :password_digest, null: false
      t.boolean :verified, null: false, default: false
      t.timestamps

      t.index %i[store_id email], unique: true
    end
  end
end
