# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores, id: :uuid do |t|
      t.string :name, null: false
      t.string :key, null: false, index: { unique: true }
      t.string :url, index: { unique: true, where: 'url IS NOT NULL' }
      t.string :locales, array: true, null: false, default: []

      t.timestamps
    end
  end
end
