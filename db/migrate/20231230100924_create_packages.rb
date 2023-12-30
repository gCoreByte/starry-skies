# frozen_string_literal: true

class CreatePackages < ActiveRecord::Migration[7.1]
  def change
    create_table :packages, id: :uuid do |t|
      t.decimal :price, null: false, precision: 20, scale: 2
      t.string :name, null: false
      t.string :key, null: false, index: { unique: true }
      t.string :features, array: true, null: false, default: []

      t.timestamps
    end
  end
end
