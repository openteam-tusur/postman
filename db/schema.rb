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

ActiveRecord::Schema.define(version: 20150317103602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contact_messages", force: :cascade do |t|
    t.integer  "contact_id"
    t.integer  "message_id"
    t.string   "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.text     "raw_email_status"
    t.string   "remote_id"
  end

  add_index "contact_messages", ["contact_id"], name: "index_contact_messages_on_contact_id", using: :btree
  add_index "contact_messages", ["message_id"], name: "index_contact_messages_on_message_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "type"
    t.string   "value"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.text     "body"
    t.string   "type"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "property_id"
  end

  add_index "messages", ["property_id"], name: "index_messages_on_property_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string   "user_id"
    t.integer  "context_id"
    t.string   "context_type"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "permissions", ["user_id", "role", "context_id", "context_type"], name: "by_user_and_role_and_context", unique: true, using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "title"
    t.string   "type"
    t.text     "url"
    t.text     "footer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.string   "email"
  end

  add_foreign_key "contact_messages", "contacts"
  add_foreign_key "contact_messages", "messages"
  add_foreign_key "messages", "properties"
end
