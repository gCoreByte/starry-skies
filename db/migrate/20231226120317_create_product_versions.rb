# frozen_string_literal: true

class CreateProductVersions < ActiveRecord::Migration[7.1]
  def change
    create_table :product_versions, id: :uuid do |t|
      t.references :product, null: false, foreign_key: true, type: :uuid
      t.string :name, null: false
      t.text :description, null: false
      t.decimal :price, null: false
      t.integer :version, null: false

      t.timestamps
    end
  end
end
