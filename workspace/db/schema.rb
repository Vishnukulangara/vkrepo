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

ActiveRecord::Schema.define(version: 20160819090027) do

  create_table "asset_categories", force: :cascade do |t|
    t.string  "asset_type",        limit: 255
    t.integer "category_id",       limit: 4
    t.integer "type_id",           limit: 4
    t.integer "asset_category_id", limit: 4
    t.string  "asset_category",    limit: 255
  end

  create_table "assets", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "specification",  limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "asset_type",     limit: 255
    t.string   "asset_category", limit: 255
    t.integer  "assigned_to",    limit: 4
    t.integer  "asset_id",       limit: 4
  end

  create_table "clients", force: :cascade do |t|
    t.string   "provider",         limit: 255
    t.string   "uid",              limit: 255
    t.string   "name",             limit: 255
    t.string   "oauth_token",      limit: 255
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "email",            limit: 255
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "website",    limit: 255
    t.string   "address",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string "name",                 limit: 255
    t.string "email",                limit: 255
    t.string "address",              limit: 255
    t.date   "date_of_birth"
    t.date   "date_of_joining"
    t.string "mobile_no",            limit: 255
    t.string "employment_status",    limit: 255
    t.string "section",              limit: 255
    t.string "bank_account_details", limit: 255
    t.string "passport_details",     limit: 255
    t.string "pancard_details",      limit: 255
    t.string "adhar_card_details",   limit: 255
    t.string "qualifications",       limit: 255
    t.string "employee_id",          limit: 255
  end

  create_table "messages", force: :cascade do |t|
    t.string   "message",      limit: 255
    t.integer  "sender_id",    limit: 4
    t.integer  "reciever_id",  limit: 4
    t.integer  "archive",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "message_copy", limit: 255
  end

  create_table "newsletters", force: :cascade do |t|
    t.string   "content",     limit: 255
    t.datetime "schedule_at"
    t.string   "sent_to",     limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.string   "role",                   limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
