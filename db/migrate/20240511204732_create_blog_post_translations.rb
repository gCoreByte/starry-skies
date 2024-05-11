# frozen_string_literal: true

class CreateBlogPostTranslations < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :blog_post_translations, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :blog_post, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :created_by, null: false, foreign_key: { to_table: :fingerprints }, type: :uuid
      t.belongs_to :updated_by, null: false, foreign_key: { to_table: :fingerprints }, type: :uuid
      t.string :locale, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps

      t.index %i[blog_post_id locale], unique: true
    end
  end
end
