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

ActiveRecord::Schema.define(version: 2020_03_10_170252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "cache_resources", force: :cascade do |t|
    t.bigint "resource_id"
    t.bigint "user_id"
    t.float "latitude"
    t.float "longitude"
    t.boolean "extracted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "amount"
    t.string "image_url"
    t.index ["resource_id"], name: "index_cache_resources_on_resource_id"
    t.index ["user_id"], name: "index_cache_resources_on_user_id"
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "sender_id"
    t.bigint "receiver_id"
    t.boolean "status"
    t.boolean "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiver_id"], name: "index_friends_on_receiver_id"
    t.index ["sender_id"], name: "index_friends_on_sender_id"
  end

  create_table "levels", force: :cascade do |t|
    t.integer "level"
    t.integer "xp"
    t.string "title"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.integer "exchange"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
  end

  create_table "structures", force: :cascade do |t|
    t.string "unit_name"
    t.integer "wood"
    t.integer "water"
    t.integer "iron"
    t.integer "gold"
    t.integer "hp"
    t.integer "attack"
    t.integer "range"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string "name"
    t.integer "attack"
    t.integer "defense"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rarity"
    t.integer "range"
    t.integer "hp"
    t.string "speciality"
  end

  create_table "user_resources", force: :cascade do |t|
    t.integer "amount"
    t.bigint "resource_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_user_resources_on_resource_id"
    t.index ["user_id"], name: "index_user_resources_on_user_id"
  end

  create_table "user_structures", force: :cascade do |t|
    t.integer "amount"
    t.integer "placed"
    t.bigint "structure_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["structure_id"], name: "index_user_structures_on_structure_id"
    t.index ["user_id"], name: "index_user_structures_on_user_id"
  end

  create_table "user_units", force: :cascade do |t|
    t.bigint "unit_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["unit_id"], name: "index_user_units_on_unit_id"
    t.index ["user_id"], name: "index_user_units_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nickname"
    t.integer "gems", default: 0
    t.string "base", default: [], array: true
    t.integer "raidcount"
    t.boolean "imgupdate"
    t.integer "xp"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cache_resources", "resources"
  add_foreign_key "cache_resources", "users"
  add_foreign_key "friends", "users", column: "receiver_id"
  add_foreign_key "friends", "users", column: "sender_id"
  add_foreign_key "user_resources", "resources"
  add_foreign_key "user_resources", "users"
  add_foreign_key "user_structures", "structures"
  add_foreign_key "user_structures", "users"
  add_foreign_key "user_units", "units"
  add_foreign_key "user_units", "users"
end
