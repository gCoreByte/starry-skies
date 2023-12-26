# frozen_string_literal: true

class CreateProductCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :product_categories, id: :uuid do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
