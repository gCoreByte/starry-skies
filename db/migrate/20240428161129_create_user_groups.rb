# frozen_string_literal: true

class CreateUserGroups < ActiveRecord::Migration[7.1]
  def change
    create_table :user_groups, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.string :name, null: false
      t.string :key, null: false
      t.integer :ranking, null: false
      t.timestamps
    end

    add_index :user_groups, %i[store_id key], unique: true
  end
end
