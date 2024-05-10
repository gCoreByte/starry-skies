# frozen_string_literal: true

class CreateProductPrices < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :product_prices, id: :uuid do |t|
      t.decimal :price, null: false
      t.datetime :deactivated_at
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.belongs_to :updated_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.belongs_to :product_version, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :user_group, foreign_key: true, type: :uuid, index: true, null: true

      t.timestamps
    end

    add_index :product_prices, %i[product_version_id user_group_id],
              unique: true, where: 'deactivated_at IS NULL AND user_group_id IS NOT NULL'
  end
end
