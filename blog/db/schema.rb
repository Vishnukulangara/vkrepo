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

ActiveRecord::Schema.define(version: 20160811050917) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "text",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "asset_categories", force: :cascade do |t|
    t.integer "category_id",    limit: 4
    t.integer "type_id",        limit: 4
    t.integer "a_c_id",         limit: 4
    t.string  "asset_category", limit: 255
    t.string  "asset_type",     limit: 255
  end

  create_table "assets", force: :cascade do |t|
    t.integer "employer_id",       limit: 4
    t.integer "employee_id",       limit: 4
    t.string  "asset_name",        limit: 255
    t.string  "working_condition", limit: 255
    t.string  "asset_id",          limit: 255
    t.string  "specification",     limit: 255
    t.string  "asset_category",    limit: 255
    t.string  "asset_type",        limit: 255
  end

  create_table "comments", force: :cascade do |t|
    t.string   "commenter",  limit: 255
    t.text     "body",       limit: 65535
    t.integer  "article_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.integer "employer_id",     limit: 4
    t.string  "company_name",    limit: 255
    t.string  "company_address", limit: 255
    t.string  "company_website", limit: 255
    t.string  "image",           limit: 255
  end

  create_table "employees", force: :cascade do |t|
    t.integer "employer_id",           limit: 4
    t.string  "name",                  limit: 255
    t.string  "email",                 limit: 255
    t.string  "date_of_birth",         limit: 255
    t.string  "address",               limit: 255
    t.string  "date_of_joining",       limit: 255
    t.string  "employment_status",     limit: 255
    t.string  "section",               limit: 255
    t.string  "bank_account_details",  limit: 255
    t.string  "adhar_no",              limit: 255
    t.string  "pancard_no",            limit: 255
    t.string  "passport_details",      limit: 255
    t.string  "qualification_details", limit: 255
    t.integer "employee_id",           limit: 4
  end

  create_table "employers", force: :cascade do |t|
    t.string  "name",             limit: 255
    t.string  "company_name",     limit: 255
    t.string  "company_address",  limit: 255
    t.string  "company_website",  limit: 255
    t.string  "image_path",       limit: 255
    t.string  "email",            limit: 255
    t.string  "password_digest",  limit: 255
    t.integer "role",             limit: 4
    t.integer "user_employer_id", limit: 4
  end

  create_table "login_histories", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.datetime "login_time"
    t.datetime "logout_time"
    t.float    "session_duration", limit: 24
  end

  add_index "login_histories", ["user_id"], name: "index_login_histories_on_user_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.string   "message",     limit: 255
    t.integer  "sender_id",   limit: 4
    t.integer  "reciever_id", limit: 4
    t.integer  "archive",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "news_letters", force: :cascade do |t|
    t.string   "content",     limit: 255
    t.string   "subject",     limit: 255
    t.datetime "schedule_at"
    t.string   "recipients",  limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name",      limit: 255
    t.string "last_name",       limit: 255
    t.string "email",           limit: 255
    t.string "password_digest", limit: 255
    t.string "mobile_no",       limit: 255
  end

  add_foreign_key "comments", "articles"
end
