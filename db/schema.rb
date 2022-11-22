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

ActiveRecord::Schema.define(version: 2022_11_21_202938) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bonuses", force: :cascade do |t|
    t.integer "amount", default: 0, null: false
    t.boolean "is_used", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "payment_id"
    t.index ["payment_id"], name: "index_bonuses_on_payment_id"
    t.index ["user_id"], name: "index_bonuses_on_user_id"
  end

  create_table "car_brands", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_rents", force: :cascade do |t|
    t.datetime "ended_at"
    t.boolean "is_paid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "car_id"
    t.bigint "user_id"
    t.index ["car_id"], name: "index_car_rents_on_car_id"
    t.index ["user_id"], name: "index_car_rents_on_user_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "price_per_min", default: 1, null: false
    t.string "name", default: "", null: false
    t.float "engine_volume", default: 2.0, null: false
    t.integer "edition_year", default: 0, null: false
    t.integer "condition", default: 10, null: false
    t.boolean "ready_to_rent", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fuel_type_id"
    t.bigint "car_brand_id"
    t.index ["car_brand_id"], name: "index_cars_on_car_brand_id"
    t.index ["fuel_type_id"], name: "index_cars_on_fuel_type_id"
  end

  create_table "documents", force: :cascade do |t|
    t.integer "status", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "fuel_types", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "images", force: :cascade do |t|
    t.string "image_url", null: false
    t.string "reference_type"
    t.bigint "reference_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reference_type", "reference_id"], name: "index_images_on_reference"
  end

  create_table "payments", force: :cascade do |t|
    t.boolean "is_paid", default: false, null: false
    t.integer "amount", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "car_rent_id"
    t.bigint "user_id"
    t.index ["car_rent_id"], name: "index_payments_on_car_rent_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", default: "t", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "second_name", default: "", null: false
    t.string "phone", default: "", null: false
    t.boolean "locked", default: false, null: false
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "bonuses", "payments"
  add_foreign_key "bonuses", "users"
  add_foreign_key "car_rents", "cars"
  add_foreign_key "car_rents", "users"
  add_foreign_key "cars", "car_brands"
  add_foreign_key "cars", "fuel_types"
  add_foreign_key "documents", "users"
  add_foreign_key "payments", "car_rents"
  add_foreign_key "payments", "users"
  add_foreign_key "users", "roles"
end
