# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_12_172752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_brands_on_deleted_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.bigint "installation_id"
    t.string "name"
    t.string "categories"
    t.string "external_id"
    t.string "retailer"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "subject"
    t.integer "page_number"
    t.index ["installation_id"], name: "index_events_on_installation_id"
    t.index ["product_id"], name: "index_events_on_product_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "installations", force: :cascade do |t|
    t.string "identifier"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_installations_on_identifier", unique: true
  end

  create_table "product_categories", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "asin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.string "teaser"
    t.string "product_type"
    t.string "option1_name"
    t.string "option1_value"
    t.money "amazon_price", scale: 2
    t.money "healthiest_price", scale: 2
    t.string "image_src"
    t.datetime "deleted_at"
    t.integer "brand_id"
    t.index ["brand_id"], name: "index_products_on_brand_id"
    t.index ["deleted_at"], name: "index_products_on_deleted_at"
    t.index ["name"], name: "index_products_on_name"
    t.index ["slug"], name: "index_products_on_slug", unique: true
  end

  create_table "retailer_categories", force: :cascade do |t|
    t.bigint "category_id"
    t.bigint "retailer_id"
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "parent_id"
    t.string "full_name"
    t.index ["category_id"], name: "index_retailer_categories_on_category_id"
    t.index ["parent_id"], name: "index_retailer_categories_on_parent_id"
    t.index ["retailer_id"], name: "index_retailer_categories_on_retailer_id"
  end

  create_table "retailer_product_products", force: :cascade do |t|
    t.bigint "retailer_product_id"
    t.bigint "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_retailer_product_products_on_product_id"
    t.index ["retailer_product_id", "product_id"], name: "index_retailer_product_products_on_rp_id_and_product_id", unique: true
    t.index ["retailer_product_id"], name: "index_retailer_product_products_on_retailer_product_id"
  end

  create_table "retailer_products", force: :cascade do |t|
    t.bigint "retailer_id"
    t.bigint "category_id"
    t.string "external_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_retailer_products_on_category_id"
    t.index ["retailer_id", "external_id"], name: "index_retailer_products_on_retailer_id_and_external_id", unique: true
    t.index ["retailer_id"], name: "index_retailer_products_on_retailer_id"
  end

  create_table "retailers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_retailers_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
