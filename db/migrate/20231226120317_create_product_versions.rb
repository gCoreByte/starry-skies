# frozen_string_literal: true

class CreateProductVersions < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    create_table :product_versions, id: :uuid do |t|
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :product, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.references :updated_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.integer :version, null: false
      t.string :locales, array: true, null: false, default: []
      t.datetime :activated_at
      t.references :activated_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: true
      t.datetime :deactivated_at
      t.references :deactivated_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: true
      t.jsonb :translations, null: false, default: {}

      t.decimal :width
      t.decimal :length
      t.decimal :height
      t.decimal :weight

      t.string :weight_unit
      t.string :size_unit

      t.timestamps
    end

    add_index :product_versions, %i[product_id version], unique: true
  end
end
