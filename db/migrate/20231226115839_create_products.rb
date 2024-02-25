# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :products, id: :uuid do |t|
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.references :updated_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false

      t.string :name, null: false
      t.string :key, null: false
      t.integer :version, null: false, default: 0
      t.string :status, null: false
      t.datetime :activated_at
      t.datetime :deactivated_at

      t.timestamps
    end

    add_index :products, %i[store_id key], unique: true
  end
end
