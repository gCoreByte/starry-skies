# frozen_string_literal: true

class CreateAdmins < ActiveRecord::Migration[7.1]
  def change
    create_table :admins, id: :uuid do |t|
      t.string :display_name, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.timestamps
    end
  end
end
