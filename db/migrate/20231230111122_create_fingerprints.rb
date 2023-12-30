# frozen_string_literal: true

class CreateFingerprints < ActiveRecord::Migration[7.1]
  def change
    create_table :fingerprints, id: :uuid do |t|
      t.string :type_key, null: false
      t.string :ip_address
      t.string :user_agent
      t.string :digest
      t.references :admin_account, null: true, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
