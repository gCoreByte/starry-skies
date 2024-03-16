# frozen_string_literal: true

class PurchaseBilling < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_billings, id: :uuid do |t|
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :purchase_order, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.string :first_name, null: false
      t.string :surname, null: false
      t.string :phone_number, null: false
      t.timestamps
    end
  end
end
