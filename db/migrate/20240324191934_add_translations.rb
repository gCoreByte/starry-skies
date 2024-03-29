# frozen_string_literal: true

class AddTranslations < ActiveRecord::Migration[7.1]
  def change
    change_table :products, bulk: true do |t|
      t.jsonb :translations, default: {}, null: false
    end
  end
end
