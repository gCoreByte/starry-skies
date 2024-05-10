# frozen_string_literal: true

class CreatePageTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :page_templates, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :created_by, null: false, foreign_key: { to_table: :fingerprints }, type: :uuid, index: true
      t.belongs_to :updated_by, null: true, foreign_key: { to_table: :fingerprints }, type: :uuid, index: true

      t.string :key, null: false
      t.string :status, null: false
      t.string :based_on, null: false

      t.timestamps

      t.index %i[store_id key], unique: true
    end
  end
end
