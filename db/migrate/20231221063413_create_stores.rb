# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores, id: :uuid do |t|
      t.string :name, null: false
      t.string :url, index: { unique: true, where: 'url IS NOT NULL' }
      t.string :locales, array: true, null: false, default: []

      t.references :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.references :updated_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false

      t.timestamps
    end
  end
end
