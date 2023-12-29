# frozen_string_literal: true

class CreateProductCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :product_categories, id: :uuid do |t|
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, null: false, foreign_key: { to_table: :admin_accounts }, type: :uuid
      t.string :name, null: false
      t.string :key, null: false
      t.jsonb :translations, null: false, default: {}

      t.timestamps
    end

    add_index :product_categories, %i[store_id key], unique: true
  end
end
