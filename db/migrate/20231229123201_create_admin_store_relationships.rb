# frozen_string_literal: true

class CreateAdminStoreRelationships < ActiveRecord::Migration[7.1]
  def change
    create_table :admin_store_relationships, id: :uuid do |t|
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :admin_account, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.string :type_key, null: false

      t.timestamps
    end

    add_index :admin_store_relationships, %i[store_id admin_account_id], unique: true
  end
end
