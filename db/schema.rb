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

ActiveRecord::Schema[8.0].define(version: 2026_09_12_000005) do
  create_table "invoices", force: :cascade do |t|
    t.integer "room_id", null: false
    t.date "billing_month", null: false
    t.decimal "base_amount", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "paid_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id", "billing_month"], name: "index_invoices_on_room_id_and_billing_month", unique: true
    t.index ["room_id"], name: "index_invoices_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "room_number"
    t.integer "floor"
    t.string "room_type"
    t.decimal "rent"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "electricity_meter_previous", default: 0, null: false
    t.integer "electricity_meter_current", default: 0, null: false
    t.decimal "electricity_rate", precision: 8, scale: 2, default: "8.0", null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "id_card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "room_id", null: false
    t.datetime "moved_out_at"
    t.index ["room_id"], name: "index_tenants_on_room_id"
  end

  add_foreign_key "invoices", "rooms"
  add_foreign_key "tenants", "rooms"
end
