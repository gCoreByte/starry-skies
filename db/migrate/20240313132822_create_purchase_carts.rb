# frozen_string_literal: true

class CreatePurchaseCarts < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_carts, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.belongs_to :updated_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.string :status, null: false
      t.datetime :expires_at
      t.timestamps
    end
  end
end
