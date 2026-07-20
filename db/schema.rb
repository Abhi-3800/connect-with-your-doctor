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

ActiveRecord::Schema[8.1].define(version: 2026_07_20_140730) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "hospital_updates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "hospital_id", null: false
    t.text "reason"
    t.datetime "updated_at", null: false
    t.string "updated_by"
    t.index ["hospital_id"], name: "index_hospital_updates_on_hospital_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "address_line1", null: false
    t.string "address_line2"
    t.string "city", null: false
    t.string "country", null: false
    t.datetime "created_at", null: false
    t.datetime "date_of_establishment", null: false
    t.string "name", null: false
    t.string "phone_number", null: false
    t.string "state", null: false
    t.datetime "updated_at", null: false
    t.string "zipcode", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "ip_address"
    t.datetime "updated_at", null: false
    t.string "user_agent"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address", null: false
    t.boolean "is_admin", default: false, null: false
    t.boolean "is_doctor", default: false, null: false
    t.string "password_digest", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "hospital_updates", "hospitals"
  add_foreign_key "sessions", "users"
end
