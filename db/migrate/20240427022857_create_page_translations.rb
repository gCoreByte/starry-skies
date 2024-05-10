# frozen_string_literal: true

class CreatePageTranslations < ActiveRecord::Migration[7.1]
  def change
    create_table :page_translations, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :page_template, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :created_by, null: false, foreign_key: { to_table: :fingerprints }, type: :uuid, index: true

      t.string :locale, null: false
      t.text :content, null: false
      t.timestamps

      t.index %i[page_template_id locale], unique: true
    end
  end
end
