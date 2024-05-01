# frozen_string_literal: true

class CreateUserUserGroup < ActiveRecord::Migration[7.1]
  def change
    create_table :user_user_groups, id: :uuid do |t|
      t.belongs_to :store, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :user_account, null: false, foreign_key: true, type: :uuid, index: true
      t.belongs_to :user_group, null: false, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end
  end
end
