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

ActiveRecord::Schema.define(version: 20170104060138) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "administrators", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.boolean  "super_admin"
    t.string   "reset_token"
    t.datetime "resent_sent_at"
    t.string   "auth_token"
  end

  create_table "birth_plan_answers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "question"
    t.integer  "ques_type"
    t.text     "answer"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "birth_plan_id"
    t.integer  "question_id"
  end

  create_table "birth_plan_questions", force: :cascade do |t|
    t.integer  "birth_plan_id"
    t.integer  "question_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "order"
  end

  create_table "birth_plans", force: :cascade do |t|
    t.string   "title"
    t.boolean  "status"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "slug"
  end

  add_index "birth_plans", ["slug"], name: "index_birth_plans_on_slug", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "news", force: :cascade do |t|
    t.string   "title"
    t.text     "excerpt"
    t.text     "link"
    t.integer  "tag_id"
    t.integer  "visits",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.date     "post_date"
    t.string   "author"
    t.string   "slug"
  end

  add_index "news", ["slug"], name: "index_news_on_slug", unique: true, using: :btree
  add_index "news", ["tag_id"], name: "index_news_on_tag_id", using: :btree

  create_table "options", force: :cascade do |t|
    t.string   "option_title"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "question_id"
  end

  add_index "options", ["question_id"], name: "index_options_on_question_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.integer  "ques_type"
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.boolean  "required"
    t.integer  "order"
  end

  add_index "questions", ["slug"], name: "index_questions_on_slug", unique: true, using: :btree

  create_table "restrict_questions", force: :cascade do |t|
    t.integer  "main_ques_id"
    t.integer  "base_ques_id"
    t.boolean  "ques_status"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "base_option_id"
    t.integer  "main_option_id"
    t.boolean  "option_status"
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
  end

  add_index "tags", ["slug"], name: "index_tags_on_slug", unique: true, using: :btree

  create_table "team_members", force: :cascade do |t|
    t.string   "name"
    t.string   "title"
    t.text     "bio"
    t.integer  "position",           default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "role"
    t.string   "subtitle"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "zipcode"
    t.date     "due_date"
    t.boolean  "terms_n_condition"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "news", "tags"
end
