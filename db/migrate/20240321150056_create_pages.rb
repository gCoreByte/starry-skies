# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :pages, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :created_by, null: false, foreign_key: { to_table: :fingerprints }, type: :uuid, index: true
      t.belongs_to :updated_by, null: true, foreign_key: { to_table: :fingerprints }, type: :uuid, index: true
      t.belongs_to :page_template, null: false, foreign_key: true, type: :uuid, index: true

      t.string :status, null: false
      t.string :key, null: false
      t.string :url, null: false

      t.timestamps

      t.index %i[store_id key], unique: true
      t.index %i[store_id url], unique: true
    end
  end
end
