# frozen_string_literal: true

class CreateProductVersionCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :product_version_categories, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :product_category, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :product_version, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.timestamps
    end
  end
end
