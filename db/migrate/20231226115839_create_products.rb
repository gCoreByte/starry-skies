# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products, id: :uuid do |t|
      t.string :name, null: false
      t.references :store, null: false, foreign_key: true, type: :uuid
      t.references :created_by, null: false, foreign_key: { to_table: :admins }, type: :uuid

      t.timestamps
    end
  end
end
