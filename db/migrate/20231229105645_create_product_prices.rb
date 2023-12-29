# frozen_string_literal: true

class CreateProductPrices < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :product_prices, id: :uuid do |t|
      t.string :locale, null: false
      t.decimal :price, null: false
      t.string :currency, null: false
      t.datetime :deactivated_at
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, null: false, foreign_key: { to_table: :admin_accounts }, type: :uuid, index: true
      t.references :product_version, null: false, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end

    add_index :product_prices, %i[product_version_id locale currency], unique: true, where: 'deactivated_at IS NOT NULL'
  end
end
