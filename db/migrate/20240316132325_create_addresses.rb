# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.1]
  def change # rubocop:disable Metrics/MethodLength
    create_table :addresses, id: :uuid do |t|
      t.references :store, null: false, foreign_key: true, type: :uuid, index: true
      t.references :created_by, foreign_key: { to_table: :fingerprints }, type: :uuid, null: false
      t.references :record, polymorphic: true, null: false, type: :uuid, index: true
      t.string :address, null: false
      t.string :city
      t.string :state
      t.string :country, null: false
      t.string :postal_code
      t.timestamps
    end
  end
end
