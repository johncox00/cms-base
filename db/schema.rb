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

ActiveRecord::Schema.define(version: 20160726221815) do

  create_table "change_sets", force: :cascade do |t|
    t.integer  "created_by"
    t.datetime "active_at"
    t.datetime "inactive_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "name"
    t.string   "workflow_state", default: "new"
  end

  create_table "cms_pages", force: :cascade do |t|
    t.string   "name",                      null: false
    t.string   "path",                      null: false
    t.string   "locale",     default: "en"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "cms_pages_content_items", force: :cascade do |t|
    t.integer  "cms_page_id"
    t.integer  "content_item_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "cms_pages_content_items", ["cms_page_id"], name: "index_cms_pages_content_items_on_cms_page_id"
  add_index "cms_pages_content_items", ["content_item_id"], name: "shorter_index"

  create_table "content_item_revisions", force: :cascade do |t|
    t.text     "content"
    t.integer  "content_item_revision_id"
    t.integer  "created_by"
    t.integer  "last_modified_by"
    t.integer  "change_set_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "identifier"
    t.string   "workflow_state"
    t.integer  "content_item_id"
  end

  add_index "content_item_revisions", ["change_set_id"], name: "index_content_item_revisions_on_change_set_id"
  add_index "content_item_revisions", ["content_item_revision_id"], name: "index_content_item_revisions_on_content_item_revision_id"

  create_table "content_items", force: :cascade do |t|
    t.string   "identifier"
    t.integer  "container_id"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "offers", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count"
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
