# frozen_string_literal: true

class CreatePurchaseCartItems < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_cart_items, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :purchase_cart, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :product_version, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :product_price, null: false, foreign_key: true, type: :uuid, index: true
      t.integer :quantity, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.timestamps
    end
  end
end
