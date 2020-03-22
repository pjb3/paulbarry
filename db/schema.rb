# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_22_044725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", id: :serial, force: :cascade do |t|
    t.string "slug", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "published_at"
    t.string "title", limit: 255, null: false
    t.text "body", null: false
    t.string "format", limit: 255, null: false
    t.string "guid", limit: 255, null: false
    t.integer "comments_count"
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["slug"], name: "index_articles_on_slug"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.integer "article_id"
    t.datetime "created_at", null: false
    t.string "url", limit: 255
    t.string "email", limit: 255
    t.string "author", limit: 255, null: false
    t.string "ip", limit: 255, null: false
    t.text "body", null: false
    t.string "guid", limit: 255
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "article_id"
    t.integer "tag_id"
    t.index ["article_id"], name: "index_taggings_on_article_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "password_digest", limit: 255
  end

  add_foreign_key "articles", "categories"
end
