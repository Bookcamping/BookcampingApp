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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150828104131) do

  create_table "colors", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "ancestry"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "library_id"
  end

  add_index "comments", ["library_id"], :name => "index_comments_on_camp_id"
  add_index "comments", ["resource_id", "resource_type"], :name => "index_comments_on_resource_id_and_resource_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "downloads", :force => true do |t|
    t.integer  "reference_id"
    t.text     "file"
    t.integer  "file_size"
    t.string   "content_type"
    t.integer  "position"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.text     "title"
    t.integer  "download_count", :default => 0
    t.text     "name"
  end

  add_index "downloads", ["reference_id"], :name => "index_downloads_on_reference_id"

  create_table "editors", :force => true do |t|
    t.integer "editable_id"
    t.string  "editable_type"
    t.integer "user_id"
    t.integer "count",         :default => 0
  end

  add_index "editors", ["editable_id", "editable_type"], :name => "index_editors_on_editable_id_and_editable_type"
  add_index "editors", ["user_id"], :name => "index_editors_on_user_id"

  create_table "followings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "followed_id"
    t.text     "followed_type"
    t.datetime "created_at"
  end

  add_index "followings", ["followed_id", "followed_type"], :name => "index_followings_on_followed_id_and_followed_type"
  add_index "followings", ["user_id"], :name => "index_followings_on_user_id"

  create_table "identities", :force => true do |t|
    t.string   "uid"
    t.integer  "user_id"
    t.string   "provider"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", :force => true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "lang"
    t.text     "settings"
    t.integer  "user_id"
    t.integer  "group_id"
    t.text     "host"
    t.integer  "memberships_count",      :default => 0
    t.text     "slug"
    t.boolean  "open",                   :default => true
    t.datetime "last_activity_email_at"
    t.text     "icon_path"
    t.text     "shelf_name"
    t.text     "description"
    t.boolean  "visible_on_header",      :default => false
    t.text     "logo"
    t.text     "slogan"
    t.text     "question"
    t.boolean  "protected",              :default => false
    t.text     "ltype",                  :default => "camping"
    t.boolean  "featured",               :default => false
    t.integer  "followers_count",        :default => 0
    t.text     "shelves_order"
  end

  add_index "libraries", ["host"], :name => "index_camps_on_host"
  add_index "libraries", ["slug"], :name => "index_camps_on_slug"

  create_table "licenses", :force => true do |t|
    t.text     "name"
    t.text     "url"
    t.text     "icon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "references_count"
    t.text     "image_url"
    t.text     "slug"
    t.text     "body"
    t.text     "license_type"
    t.boolean  "libre",            :default => false
  end

  create_table "media_bites", :force => true do |t|
    t.integer  "camp_id"
    t.integer  "user_id"
    t.text     "title"
    t.text     "caption"
    t.text     "link"
    t.text     "content_type"
    t.text     "file_content"
    t.text     "render_as"
    t.text     "position"
    t.integer  "width"
    t.integer  "height"
    t.text     "url_content"
    t.text     "text_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "author",         :limit => 100
    t.string   "title",          :limit => 200
    t.text     "body"
    t.string   "visibility",     :limit => 16
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                :default => 0
    t.string   "content_type",   :limit => 32
    t.string   "slug",           :limit => 200
  end

  create_table "publishers", :force => true do |t|
    t.text     "name"
    t.text     "slug"
    t.text     "header_url"
    t.text     "homepage_url"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.text     "archive_slug"
    t.integer  "references_count", :default => 0
  end

  add_index "publishers", ["slug"], :name => "index_publishers_on_slug", :unique => true

  create_table "recommendations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reference_id"
    t.datetime "created_at"
  end

  add_index "recommendations", ["reference_id"], :name => "index_recommendations_on_reference_id"
  add_index "recommendations", ["user_id"], :name => "index_recommendations_on_user_id"

  create_table "references", :force => true do |t|
    t.integer  "user_id"
    t.text     "title"
    t.text     "authors"
    t.text     "editor"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",        :default => 0
    t.text     "media"
    t.text     "media_type"
    t.text     "date"
    t.integer  "library_id"
    t.text     "marks"
    t.integer  "license_id"
    t.integer  "publisher_id"
    t.text     "ref_type"
    t.text     "archive_slug"
    t.integer  "group_id"
    t.boolean  "open",                  :default => true
    t.text     "tag_names"
    t.integer  "recommendations_count", :default => 0
    t.integer  "shelf_items_count",     :default => 0
    t.integer  "reviews_count",         :default => 0
    t.integer  "downloads_count",       :default => 0
    t.boolean  "libre",                 :default => false
    t.integer  "taggings_count",        :default => 0
    t.boolean  "featured",              :default => false
    t.text     "cover_image"
    t.text     "url1"
    t.text     "url2"
    t.text     "url3"
  end

  add_index "references", ["library_id"], :name => "index_books_on_camp_id"
  add_index "references", ["user_id"], :name => "index_books_on_user_id"

  create_table "reviews", :force => true do |t|
    t.integer  "reference_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "reviews", ["reference_id"], :name => "index_reviews_on_reference_id"
  add_index "reviews", ["user_id"], :name => "index_reviews_on_user_id"

  create_table "shelf_items", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "reference_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.text     "description"
  end

  add_index "shelf_items", ["reference_id"], :name => "index_shelf_items_on_book_id"
  add_index "shelf_items", ["shelf_id"], :name => "index_shelf_items_on_shelf_id"
  add_index "shelf_items", ["user_id"], :name => "index_shelf_items_on_user_id"

  create_table "shelf_members", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "shelves", :force => true do |t|
    t.integer  "user_id"
    t.text     "name"
    t.text     "slug"
    t.integer  "references_count",  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "library_id"
    t.text     "color"
    t.text     "description"
    t.integer  "memberships_count", :default => 0
    t.text     "visualization"
    t.boolean  "protected",         :default => false
    t.boolean  "featured",          :default => false
    t.integer  "taggings_count",    :default => 0
    t.integer  "followers_count",   :default => 0
  end

  add_index "shelves", ["library_id"], :name => "index_shelves_on_camp_id"
  add_index "shelves", ["slug"], :name => "index_shelves_on_slug"
  add_index "shelves", ["user_id"], :name => "index_shelves_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer "tagged_id"
    t.integer "tag_id"
    t.text    "tagged_type"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["tagged_id"], :name => "index_taggings_on_reference_id"

  create_table "tags", :force => true do |t|
    t.text     "name"
    t.text     "slug"
    t.integer  "taggings_count", :default => 0
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "users", :force => true do |t|
    t.text     "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count",           :default => 0
    t.datetime "last_login_at"
    t.text     "twitter"
    t.text     "description"
    t.text     "slug"
    t.text     "settings"
    t.string   "password_digest"
    t.string   "uid_twitter"
    t.string   "uid_facebook"
    t.string   "uid_google"
    t.string   "recovery_code"
    t.text     "avatar"
    t.integer  "versions_count",        :default => 0
    t.boolean  "admin",                 :default => false
    t.integer  "recommendations_count", :default => 0
    t.boolean  "email_notifications",   :default => true
    t.boolean  "email_pending",         :default => false
    t.integer  "references_count",      :default => 0
    t.boolean  "watcher",               :default => false
  end

  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "versions", :force => true do |t|
    t.string   "item_type",    :limit => 40,                   :null => false
    t.integer  "item_id",                                      :null => false
    t.string   "event",                                        :null => false
    t.string   "whodunnit"
    t.text     "title"
    t.text     "user_name"
    t.text     "object"
    t.datetime "created_at"
    t.integer  "library_id"
    t.integer  "shelf_id"
    t.boolean  "activity",                   :default => true
    t.integer  "user_id"
    t.integer  "reference_id"
  end

  add_index "versions", ["event"], :name => "index_versions_on_event"
  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  add_index "versions", ["item_type"], :name => "index_versions_on_item_type"
  add_index "versions", ["library_id"], :name => "index_versions_on_camp_id"
  add_index "versions", ["reference_id"], :name => "index_versions_on_reference_id"
  add_index "versions", ["shelf_id"], :name => "index_versions_on_shelf_id"
  add_index "versions", ["user_id"], :name => "index_versions_on_user_id"

end
