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

ActiveRecord::Schema.define(version: 20131011220210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "slug",           null: false
    t.datetime "created_at",     null: false
    t.datetime "published_at"
    t.string   "title",          null: false
    t.text     "body",           null: false
    t.string   "format",         null: false
    t.string   "guid",           null: false
    t.integer  "comments_count"
  end

  add_index "articles", ["slug"], name: "index_articles_on_slug", using: :btree

  create_table "categories", force: true do |t|
    t.string "name", null: false
  end

  create_table "categorizations", force: true do |t|
    t.integer "article_id"
    t.integer "category_id"
  end

  add_index "categorizations", ["article_id"], name: "index_categorizations_on_article_id", using: :btree
  add_index "categorizations", ["category_id"], name: "index_categorizations_on_category_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.string   "url"
    t.string   "email"
    t.string   "author",     null: false
    t.string   "ip",         null: false
    t.text     "body",       null: false
    t.string   "guid"
  end

  add_index "comments", ["article_id"], name: "index_comments_on_article_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer "article_id"
    t.integer "tag_id"
  end

  add_index "taggings", ["article_id"], name: "index_taggings_on_article_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string "name", null: false
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
