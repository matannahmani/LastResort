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

ActiveRecord::Schema.define(version: 2020_02_25_140016) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.integer "exchange"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resources"
    t.bigint "user_resource_id"
    t.index ["user_resource_id"], name: "index_resources_on_user_resource_id"
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
    t.bigint "user_unit_id"
    t.string "rarity"
    t.integer "range"
    t.integer "hp"
    t.string "speciality"
    t.index ["user_unit_id"], name: "index_units_on_user_unit_id"
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
    t.json "base"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "resources", "user_resources"
  add_foreign_key "units", "user_units"
  add_foreign_key "user_resources", "resources"
  add_foreign_key "user_resources", "users"
  add_foreign_key "user_units", "units"
  add_foreign_key "user_units", "users"
end
