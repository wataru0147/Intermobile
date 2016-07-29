# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160728222524) do

  create_table "car_manufacturers", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "car_models", force: :cascade do |t|
    t.string   "name"
    t.integer  "car_manufacturer_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "car_models", ["car_manufacturer_id"], name: "index_car_models_on_car_manufacturer_id"

  create_table "cars", force: :cascade do |t|
    t.string   "plate_number"
    t.string   "year"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "car_model_id"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  add_index "cars", ["car_model_id"], name: "index_cars_on_car_model_id"
  add_index "cars", ["user_id"], name: "index_cars_on_user_id"

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.integer  "service_transaction_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "comments", ["service_transaction_id"], name: "index_comments_on_service_transaction_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "notified_by_id"
    t.integer  "car_id"
    t.integer  "service_transaction_id"
    t.integer  "identifier"
    t.string   "notice_type"
    t.boolean  "read",                   default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "notifications", ["car_id"], name: "index_notifications_on_car_id"
  add_index "notifications", ["notified_by_id"], name: "index_notifications_on_notified_by_id"
  add_index "notifications", ["service_transaction_id"], name: "index_notifications_on_service_transaction_id"
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "service_todos", force: :cascade do |t|
    t.datetime "paid_at"
    t.datetime "completed_at"
    t.datetime "started_at"
    t.integer  "service_transaction_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "service_id"
    t.integer  "technician_in_charge_id"
  end

  add_index "service_todos", ["service_id"], name: "index_service_todos_on_service_id"
  add_index "service_todos", ["service_transaction_id"], name: "index_service_todos_on_service_transaction_id"
  add_index "service_todos", ["technician_in_charge_id"], name: "index_service_todos_on_technician_in_charge_id"

  create_table "service_transactions", force: :cascade do |t|
    t.datetime "started_at"
    t.datetime "finished_at"
    t.integer  "car_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "staff_in_charge_id"
    t.integer  "technician_in_charge_id"
  end

  add_index "service_transactions", ["car_id"], name: "index_service_transactions_on_car_id"
  add_index "service_transactions", ["staff_in_charge_id"], name: "index_service_transactions_on_staff_in_charge_id"
  add_index "service_transactions", ["technician_in_charge_id"], name: "index_service_transactions_on_technician_in_charge_id"

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role_id"
    t.string   "contact_number_prefix"
    t.string   "contact_number"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["role_id"], name: "index_users_on_role_id"

end
