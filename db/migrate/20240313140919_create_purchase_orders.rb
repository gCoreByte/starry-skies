# frozen_string_literal: true

class CreatePurchaseOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_orders, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :purchase_cart, null: false, foreign_key: true, type: :uuid, index: true
      t.string :status, null: false
      t.string :first_name, null: false
      t.string :surname, null: false
      t.string :phone_number, null: false
      t.timestamps
    end
  end
end
