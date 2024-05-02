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

ActiveRecord::Schema[7.1].define(version: 2024_05_01_213710) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.string "record_type", null: false
    t.uuid "record_id", null: false
    t.string "address", null: false
    t.string "city"
    t.string "state"
    t.string "country", null: false
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_addresses_on_created_by_id"
    t.index ["record_type", "record_id"], name: "index_addresses_on_record"
    t.index ["store_id"], name: "index_addresses_on_store_id"
  end

  create_table "admin_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
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
    t.uuid "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_account_id"], name: "index_admin_store_permissions_on_admin_account_id"
    t.index ["created_by_id"], name: "index_admin_store_permissions_on_created_by_id"
    t.index ["store_id", "admin_account_id", "type_key"], name: "idx_on_store_id_admin_account_id_type_key_4b4085dd04", unique: true
    t.index ["store_id"], name: "index_admin_store_permissions_on_store_id"
  end

  create_table "admin_store_relationships", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "admin_account_id", null: false
    t.uuid "created_by_id", null: false
    t.string "type_key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_account_id"], name: "index_admin_store_relationships_on_admin_account_id"
    t.index ["created_by_id"], name: "index_admin_store_relationships_on_created_by_id"
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
    t.uuid "user_session_id"
    t.uuid "user_account_id"
    t.index ["admin_account_id"], name: "index_fingerprints_on_admin_account_id"
    t.index ["user_account_id"], name: "index_fingerprints_on_user_account_id"
    t.index ["user_session_id"], name: "index_fingerprints_on_user_session_id"
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

  create_table "page_components", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.text "content", null: false
    t.string "based_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_page_components_on_created_by_id"
    t.index ["store_id"], name: "index_page_components_on_store_id"
    t.index ["updated_by_id"], name: "index_page_components_on_updated_by_id"
  end

  create_table "page_template_changes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "page_template_id", null: false
    t.text "content", null: false
    t.string "status", null: false
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_page_template_changes_on_created_by_id"
    t.index ["page_template_id"], name: "index_page_template_changes_on_page_template_id"
    t.index ["store_id"], name: "index_page_template_changes_on_store_id"
  end

  create_table "page_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.string "key", null: false
    t.string "status", null: false
    t.string "based_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_page_templates_on_created_by_id"
    t.index ["store_id", "key"], name: "index_page_templates_on_store_id_and_key", unique: true
    t.index ["store_id"], name: "index_page_templates_on_store_id"
    t.index ["updated_by_id"], name: "index_page_templates_on_updated_by_id"
  end

  create_table "page_translations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "page_template_id", null: false
    t.uuid "created_by_id", null: false
    t.string "locale", null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_page_translations_on_created_by_id"
    t.index ["page_template_id", "locale"], name: "index_page_translations_on_page_template_id_and_locale", unique: true
    t.index ["page_template_id"], name: "index_page_translations_on_page_template_id"
    t.index ["store_id"], name: "index_page_translations_on_store_id"
  end

  create_table "pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id"
    t.uuid "page_template_id", null: false
    t.string "status", null: false
    t.string "key", null: false
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_pages_on_created_by_id"
    t.index ["page_template_id"], name: "index_pages_on_page_template_id"
    t.index ["store_id", "key"], name: "index_pages_on_store_id_and_key", unique: true
    t.index ["store_id", "url"], name: "index_pages_on_store_id_and_url", unique: true
    t.index ["store_id"], name: "index_pages_on_store_id"
    t.index ["updated_by_id"], name: "index_pages_on_updated_by_id"
  end

  create_table "product_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.string "name", null: false
    t.string "key", null: false
    t.jsonb "translations", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_product_categories_on_created_by_id"
    t.index ["store_id", "key"], name: "index_product_categories_on_store_id_and_key", unique: true
    t.index ["store_id"], name: "index_product_categories_on_store_id"
    t.index ["updated_by_id"], name: "index_product_categories_on_updated_by_id"
  end

  create_table "product_prices", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.decimal "price", null: false
    t.datetime "deactivated_at"
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.uuid "product_version_id", null: false
    t.uuid "user_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_product_prices_on_created_by_id"
    t.index ["product_version_id", "user_group_id"], name: "index_product_prices_on_product_version_id_and_user_group_id", unique: true, where: "((deactivated_at IS NULL) AND (user_group_id IS NOT NULL))"
    t.index ["product_version_id"], name: "index_product_prices_on_product_version_id"
    t.index ["store_id"], name: "index_product_prices_on_store_id"
    t.index ["updated_by_id"], name: "index_product_prices_on_updated_by_id"
    t.index ["user_group_id"], name: "index_product_prices_on_user_group_id"
  end

  create_table "product_version_categories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "product_category_id", null: false
    t.uuid "product_version_id", null: false
    t.uuid "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_product_version_categories_on_created_by_id"
    t.index ["product_category_id"], name: "index_product_version_categories_on_product_category_id"
    t.index ["product_version_id"], name: "index_product_version_categories_on_product_version_id"
    t.index ["store_id"], name: "index_product_version_categories_on_store_id"
  end

  create_table "product_versions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "product_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.integer "version", null: false
    t.string "locales", default: [], null: false, array: true
    t.datetime "activated_at"
    t.uuid "activated_by_id"
    t.datetime "deactivated_at"
    t.uuid "deactivated_by_id"
    t.jsonb "translations", default: {}, null: false
    t.decimal "width"
    t.decimal "length"
    t.decimal "height"
    t.decimal "weight"
    t.string "weight_unit"
    t.string "size_unit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activated_by_id"], name: "index_product_versions_on_activated_by_id"
    t.index ["created_by_id"], name: "index_product_versions_on_created_by_id"
    t.index ["deactivated_by_id"], name: "index_product_versions_on_deactivated_by_id"
    t.index ["product_id", "version"], name: "index_product_versions_on_product_id_and_version", unique: true
    t.index ["product_id"], name: "index_product_versions_on_product_id"
    t.index ["store_id"], name: "index_product_versions_on_store_id"
    t.index ["updated_by_id"], name: "index_product_versions_on_updated_by_id"
  end

  create_table "products", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.string "key", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_products_on_created_by_id"
    t.index ["store_id", "key"], name: "index_products_on_store_id_and_key", unique: true
    t.index ["store_id"], name: "index_products_on_store_id"
    t.index ["updated_by_id"], name: "index_products_on_updated_by_id"
  end

  create_table "purchase_billings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "purchase_order_id", null: false
    t.uuid "created_by_id", null: false
    t.string "first_name", null: false
    t.string "surname", null: false
    t.string "phone_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_purchase_billings_on_created_by_id"
    t.index ["purchase_order_id"], name: "index_purchase_billings_on_purchase_order_id"
    t.index ["store_id"], name: "index_purchase_billings_on_store_id"
  end

  create_table "purchase_cart_items", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "purchase_cart_id", null: false
    t.uuid "product_version_id", null: false
    t.uuid "product_price_id", null: false
    t.integer "quantity", null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_price_id"], name: "index_purchase_cart_items_on_product_price_id"
    t.index ["product_version_id"], name: "index_purchase_cart_items_on_product_version_id"
    t.index ["purchase_cart_id"], name: "index_purchase_cart_items_on_purchase_cart_id"
    t.index ["store_id"], name: "index_purchase_cart_items_on_store_id"
  end

  create_table "purchase_carts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.string "status", null: false
    t.datetime "expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_account_id"
    t.uuid "user_session_id"
    t.index ["created_by_id"], name: "index_purchase_carts_on_created_by_id"
    t.index ["store_id"], name: "index_purchase_carts_on_store_id"
    t.index ["updated_by_id"], name: "index_purchase_carts_on_updated_by_id"
    t.index ["user_account_id"], name: "index_purchase_carts_on_user_account_id"
    t.index ["user_session_id"], name: "index_purchase_carts_on_user_session_id"
  end

  create_table "purchase_orders", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "purchase_cart_id", null: false
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.string "status", null: false
    t.string "first_name", null: false
    t.string "surname", null: false
    t.string "phone_number", null: false
    t.integer "reference_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_purchase_orders_on_created_by_id"
    t.index ["purchase_cart_id"], name: "index_purchase_orders_on_purchase_cart_id"
    t.index ["store_id"], name: "index_purchase_orders_on_store_id"
    t.index ["updated_by_id"], name: "index_purchase_orders_on_updated_by_id"
  end

  create_table "sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "admin_account_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_account_id"], name: "index_sessions_on_admin_account_id"
  end

  create_table "solid_queue_blocked_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.string "concurrency_key", null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.index ["concurrency_key", "priority", "job_id"], name: "index_solid_queue_blocked_executions_for_release"
    t.index ["expires_at", "concurrency_key"], name: "index_solid_queue_blocked_executions_for_maintenance"
    t.index ["job_id"], name: "index_solid_queue_blocked_executions_on_job_id", unique: true
  end

  create_table "solid_queue_claimed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.bigint "process_id"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_claimed_executions_on_job_id", unique: true
    t.index ["process_id", "job_id"], name: "index_solid_queue_claimed_executions_on_process_id_and_job_id"
  end

  create_table "solid_queue_failed_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.text "error"
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_failed_executions_on_job_id", unique: true
  end

  create_table "solid_queue_jobs", force: :cascade do |t|
    t.string "queue_name", null: false
    t.string "class_name", null: false
    t.text "arguments"
    t.integer "priority", default: 0, null: false
    t.string "active_job_id"
    t.datetime "scheduled_at"
    t.datetime "finished_at"
    t.string "concurrency_key"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active_job_id"], name: "index_solid_queue_jobs_on_active_job_id"
    t.index ["class_name"], name: "index_solid_queue_jobs_on_class_name"
    t.index ["finished_at"], name: "index_solid_queue_jobs_on_finished_at"
    t.index ["queue_name", "finished_at"], name: "index_solid_queue_jobs_for_filtering"
    t.index ["scheduled_at", "finished_at"], name: "index_solid_queue_jobs_for_alerting"
  end

  create_table "solid_queue_pauses", force: :cascade do |t|
    t.string "queue_name", null: false
    t.datetime "created_at", null: false
    t.index ["queue_name"], name: "index_solid_queue_pauses_on_queue_name", unique: true
  end

  create_table "solid_queue_processes", force: :cascade do |t|
    t.string "kind", null: false
    t.datetime "last_heartbeat_at", null: false
    t.bigint "supervisor_id"
    t.integer "pid", null: false
    t.string "hostname"
    t.text "metadata"
    t.datetime "created_at", null: false
    t.index ["last_heartbeat_at"], name: "index_solid_queue_processes_on_last_heartbeat_at"
    t.index ["supervisor_id"], name: "index_solid_queue_processes_on_supervisor_id"
  end

  create_table "solid_queue_ready_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_ready_executions_on_job_id", unique: true
    t.index ["priority", "job_id"], name: "index_solid_queue_poll_all"
    t.index ["queue_name", "priority", "job_id"], name: "index_solid_queue_poll_by_queue"
  end

  create_table "solid_queue_recurring_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "task_key", null: false
    t.datetime "run_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_recurring_executions_on_job_id", unique: true
    t.index ["task_key", "run_at"], name: "index_solid_queue_recurring_executions_on_task_key_and_run_at", unique: true
  end

  create_table "solid_queue_scheduled_executions", force: :cascade do |t|
    t.bigint "job_id", null: false
    t.string "queue_name", null: false
    t.integer "priority", default: 0, null: false
    t.datetime "scheduled_at", null: false
    t.datetime "created_at", null: false
    t.index ["job_id"], name: "index_solid_queue_scheduled_executions_on_job_id", unique: true
    t.index ["scheduled_at", "priority", "job_id"], name: "index_solid_queue_dispatch_all"
  end

  create_table "solid_queue_semaphores", force: :cascade do |t|
    t.string "key", null: false
    t.integer "value", default: 1, null: false
    t.datetime "expires_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expires_at"], name: "index_solid_queue_semaphores_on_expires_at"
    t.index ["key", "value"], name: "index_solid_queue_semaphores_on_key_and_value"
    t.index ["key"], name: "index_solid_queue_semaphores_on_key", unique: true
  end

  create_table "stores", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "url"
    t.string "locales", default: [], null: false, array: true
    t.uuid "created_by_id", null: false
    t.uuid "updated_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "package_id", null: false
    t.index ["created_by_id"], name: "index_stores_on_created_by_id"
    t.index ["package_id"], name: "index_stores_on_package_id"
    t.index ["updated_by_id"], name: "index_stores_on_updated_by_id"
    t.index ["url"], name: "index_stores_on_url", unique: true, where: "(url IS NOT NULL)"
  end

  create_table "user_accounts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.boolean "verified", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "email"], name: "index_user_accounts_on_store_id_and_email", unique: true
    t.index ["store_id"], name: "index_user_accounts_on_store_id"
  end

  create_table "user_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.string "name", null: false
    t.string "key", null: false
    t.integer "ranking", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "key"], name: "index_user_groups_on_store_id_and_key", unique: true
    t.index ["store_id"], name: "index_user_groups_on_store_id"
  end

  create_table "user_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "cookie", null: false
    t.datetime "expires_at", null: false
    t.uuid "store_id", null: false
    t.uuid "user_account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id", "cookie"], name: "index_user_sessions_on_store_id_and_cookie", unique: true
    t.index ["store_id"], name: "index_user_sessions_on_store_id"
    t.index ["user_account_id"], name: "index_user_sessions_on_user_account_id"
  end

  create_table "user_user_groups", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "store_id", null: false
    t.uuid "user_account_id", null: false
    t.uuid "user_group_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["store_id"], name: "index_user_user_groups_on_store_id"
    t.index ["user_account_id"], name: "index_user_user_groups_on_user_account_id"
    t.index ["user_group_id"], name: "index_user_user_groups_on_user_group_id"
  end

  add_foreign_key "addresses", "fingerprints", column: "created_by_id"
  add_foreign_key "addresses", "stores"
  add_foreign_key "admin_store_permissions", "admin_accounts"
  add_foreign_key "admin_store_permissions", "fingerprints", column: "created_by_id"
  add_foreign_key "admin_store_permissions", "stores"
  add_foreign_key "admin_store_relationships", "admin_accounts"
  add_foreign_key "admin_store_relationships", "fingerprints", column: "created_by_id"
  add_foreign_key "admin_store_relationships", "stores"
  add_foreign_key "fingerprints", "admin_accounts"
  add_foreign_key "fingerprints", "user_accounts"
  add_foreign_key "fingerprints", "user_sessions"
  add_foreign_key "page_components", "fingerprints", column: "created_by_id"
  add_foreign_key "page_components", "fingerprints", column: "updated_by_id"
  add_foreign_key "page_components", "stores"
  add_foreign_key "page_template_changes", "fingerprints", column: "created_by_id"
  add_foreign_key "page_template_changes", "page_templates"
  add_foreign_key "page_template_changes", "stores"
  add_foreign_key "page_templates", "fingerprints", column: "created_by_id"
  add_foreign_key "page_templates", "fingerprints", column: "updated_by_id"
  add_foreign_key "page_templates", "stores"
  add_foreign_key "page_translations", "fingerprints", column: "created_by_id"
  add_foreign_key "page_translations", "page_templates"
  add_foreign_key "page_translations", "stores"
  add_foreign_key "pages", "fingerprints", column: "created_by_id"
  add_foreign_key "pages", "fingerprints", column: "updated_by_id"
  add_foreign_key "pages", "page_templates"
  add_foreign_key "pages", "stores"
  add_foreign_key "product_categories", "fingerprints", column: "created_by_id"
  add_foreign_key "product_categories", "fingerprints", column: "updated_by_id"
  add_foreign_key "product_categories", "stores"
  add_foreign_key "product_prices", "fingerprints", column: "created_by_id"
  add_foreign_key "product_prices", "fingerprints", column: "updated_by_id"
  add_foreign_key "product_prices", "product_versions"
  add_foreign_key "product_prices", "stores"
  add_foreign_key "product_prices", "user_groups"
  add_foreign_key "product_version_categories", "fingerprints", column: "created_by_id"
  add_foreign_key "product_version_categories", "product_categories"
  add_foreign_key "product_version_categories", "product_versions"
  add_foreign_key "product_version_categories", "stores"
  add_foreign_key "product_versions", "fingerprints", column: "activated_by_id"
  add_foreign_key "product_versions", "fingerprints", column: "created_by_id"
  add_foreign_key "product_versions", "fingerprints", column: "deactivated_by_id"
  add_foreign_key "product_versions", "fingerprints", column: "updated_by_id"
  add_foreign_key "product_versions", "products"
  add_foreign_key "product_versions", "stores"
  add_foreign_key "products", "fingerprints", column: "created_by_id"
  add_foreign_key "products", "fingerprints", column: "updated_by_id"
  add_foreign_key "products", "stores"
  add_foreign_key "purchase_billings", "fingerprints", column: "created_by_id"
  add_foreign_key "purchase_billings", "purchase_orders"
  add_foreign_key "purchase_billings", "stores"
  add_foreign_key "purchase_cart_items", "product_prices"
  add_foreign_key "purchase_cart_items", "product_versions"
  add_foreign_key "purchase_cart_items", "purchase_carts"
  add_foreign_key "purchase_cart_items", "stores"
  add_foreign_key "purchase_carts", "fingerprints", column: "created_by_id"
  add_foreign_key "purchase_carts", "fingerprints", column: "updated_by_id"
  add_foreign_key "purchase_carts", "stores"
  add_foreign_key "purchase_carts", "user_accounts"
  add_foreign_key "purchase_carts", "user_sessions"
  add_foreign_key "purchase_orders", "fingerprints", column: "created_by_id"
  add_foreign_key "purchase_orders", "fingerprints", column: "updated_by_id"
  add_foreign_key "purchase_orders", "purchase_carts"
  add_foreign_key "purchase_orders", "stores"
  add_foreign_key "sessions", "admin_accounts"
  add_foreign_key "solid_queue_blocked_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_claimed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_failed_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_ready_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_recurring_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "solid_queue_scheduled_executions", "solid_queue_jobs", column: "job_id", on_delete: :cascade
  add_foreign_key "stores", "fingerprints", column: "created_by_id"
  add_foreign_key "stores", "fingerprints", column: "updated_by_id"
  add_foreign_key "stores", "packages"
  add_foreign_key "user_accounts", "stores"
  add_foreign_key "user_groups", "stores"
  add_foreign_key "user_sessions", "stores"
  add_foreign_key "user_sessions", "user_accounts"
  add_foreign_key "user_user_groups", "stores"
  add_foreign_key "user_user_groups", "user_accounts"
  add_foreign_key "user_user_groups", "user_groups"
end
