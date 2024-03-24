# frozen_string_literal: true

class CreatePageTemplateChanges < ActiveRecord::Migration[7.1]
  def change
    create_table :page_template_changes, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :created_by, null: false, foreign_key: { to_table: :fingerprints }, type: :uuid, index: true
      t.belongs_to :page_template, null: false, foreign_key: true, type: :uuid, index: true

      t.text :content, null: false
      t.string :status, null: false

      t.timestamps
    end
  end
end
