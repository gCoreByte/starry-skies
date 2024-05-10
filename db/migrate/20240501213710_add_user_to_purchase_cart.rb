# frozen_string_literal: true

class AddUserToPurchaseCart < ActiveRecord::Migration[7.1]
  def change
    change_table :purchase_carts, bulk: true do |t|
      t.belongs_to :user_account, null: true, foreign_key: true, type: :uuid, index: true
      t.belongs_to :user_session, null: true, foreign_key: true, type: :uuid, index: true
    end
  end
end
