class InitialSchema < ActiveRecord::Migration
  def change
    create_table "articles" do |t|
      t.string   "slug",           :null => false
      t.datetime "created_at",     :null => false
      t.datetime "published_at"
      t.string   "title",          :null => false
      t.text     "body",           :null => false
      t.string   "format",         :null => false
      t.string   "guid",           :null => false
      t.integer  "comments_count"
    end

    add_index :articles, :slug

    create_table "categories" do |t|
      t.string "name", :null => false
    end

    create_table "categorizations" do |t|
      t.integer "article_id"
      t.integer "category_id"
    end

    add_index "categorizations", ["article_id"]
    add_index "categorizations", ["category_id"]

    create_table "comments" do |t|
      t.integer  "article_id"
      t.datetime "created_at",              :null => false
      t.string   "url"
      t.string   "email"
      t.string   "author",                  :null => false
      t.string   "ip",                      :null => false
      t.text     "body",                    :null => false
      t.string   "guid"
    end

    add_index "comments", ["article_id"]

    create_table "taggings" do |t|
      t.integer "article_id"
      t.integer "tag_id"
    end

    add_index "taggings", ["article_id"]
    add_index "taggings", ["tag_id"]

    create_table "tags" do |t|
      t.string "name", :null => false
    end

    create_table "users" do |t|
      t.string   "username"
      t.string   "password"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
