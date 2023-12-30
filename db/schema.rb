# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2023_12_30_111122) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "admin_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "display_name", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_accounts_on_email", unique: true
  end

  create_table "admin_store_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type_key", null: false
    t.uuid "store_id", null: false
    t.uuid "admin_account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_account_id"], name: "index_admin_store_permissions_on_admin_account_id"
    t.index ["store_id", "admin_account_id", "type_key"], name: "idx_on_store_id_admin_account_id_type_key_4b4085dd04", unique: true
    t.index ["store_id"], name: "index_admin_store_permissions_on_store_id"
  end

  create_table "admin_store_relationships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "admin_account_id", null: false
    t.string "type_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_account_id"], name: "index_admin_store_relationships_on_admin_account_id"
    t.index ["store_id", "admin_account_id"], name: "idx_on_store_id_admin_account_id_05666a13a8", unique: true
    t.index ["store_id"], name: "index_admin_store_relationships_on_store_id"
  end

  create_table "fingerprints", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "type_key", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.string "digest"
    t.uuid "admin_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_account_id"], name: "index_fingerprints_on_admin_account_id"
  end

  create_table "packages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "price", precision: 20, scale: 2, null: false
    t.string "name", null: false
    t.string "key", null: false
    t.string "features", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_packages_on_key", unique: true
  end

  create_table "product_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.string "name", null: false
    t.string "key", null: false
    t.jsonb "translations", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_product_categories_on_created_by_id"
    t.index ["store_id", "key"], name: "index_product_categories_on_store_id_and_key", unique: true
    t.index ["store_id"], name: "index_product_categories_on_store_id"
  end

  create_table "product_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "locale", null: false
    t.decimal "price", null: false
    t.string "currency", null: false
    t.datetime "deactivated_at"
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "product_version_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_product_prices_on_created_by_id"
    t.index ["product_version_id", "locale", "currency"], name: "idx_on_product_version_id_locale_currency_42358d636c", unique: true, where: "(deactivated_at IS NOT NULL)"
    t.index ["product_version_id"], name: "index_product_prices_on_product_version_id"
    t.index ["store_id"], name: "index_product_prices_on_store_id"
  end

  create_table "product_versions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "product_id", null: false
    t.uuid "created_by_id", null: false
    t.text "description", null: false
    t.integer "version", null: false
    t.string "status", null: false
    t.string "locales", default: [], null: false, array: true
    t.datetime "activated_at"
    t.datetime "deactivated_at"
    t.jsonb "translations", default: {}, null: false
    t.decimal "width"
    t.decimal "length"
    t.decimal "height"
    t.decimal "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_product_versions_on_created_by_id"
    t.index ["product_id", "version"], name: "index_product_versions_on_product_id_and_version", unique: true
    t.index ["product_id"], name: "index_product_versions_on_product_id"
    t.index ["store_id"], name: "index_product_versions_on_store_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.string "name", null: false
    t.string "key", null: false
    t.integer "version", default: 0, null: false
    t.string "status", null: false
    t.datetime "activated_at"
    t.datetime "deactivated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "key"], name: "index_products_on_store_id_and_key", unique: true
    t.index ["store_id"], name: "index_products_on_store_id"
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "admin_account_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_account_id"], name: "index_sessions_on_admin_account_id"
  end

  create_table "stores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "key", null: false
    t.string "url"
    t.string "locales", default: [], null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_stores_on_key", unique: true
    t.index ["url"], name: "index_stores_on_url", unique: true, where: "(url IS NOT NULL)"
  end

  add_foreign_key "admin_store_permissions", "admin_accounts"
  add_foreign_key "admin_store_permissions", "stores"
  add_foreign_key "admin_store_relationships", "admin_accounts"
  add_foreign_key "admin_store_relationships", "stores"
  add_foreign_key "fingerprints", "admin_accounts"
  add_foreign_key "product_categories", "admin_accounts", column: "created_by_id"
  add_foreign_key "product_categories", "stores"
  add_foreign_key "product_prices", "admin_accounts", column: "created_by_id"
  add_foreign_key "product_prices", "product_versions"
  add_foreign_key "product_prices", "stores"
  add_foreign_key "product_versions", "admin_accounts", column: "created_by_id"
  add_foreign_key "product_versions", "products"
  add_foreign_key "product_versions", "stores"
  add_foreign_key "products", "stores"
  add_foreign_key "sessions", "admin_accounts"
end
