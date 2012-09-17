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

ActiveRecord::Schema.define(:version => 20120916221829) do

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
    t.string   "body",          :limit => 512
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "library_id"
  end

  add_index "comments", ["library_id"], :name => "index_comments_on_camp_id"
  add_index "comments", ["resource_id", "resource_type"], :name => "index_comments_on_resource_id_and_resource_type"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "identities", :force => true do |t|
    t.string   "uid"
    t.integer  "user_id"
    t.string   "provider"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "libraries", :force => true do |t|
    t.string   "name",                   :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "show_media_on_lists",                   :default => false
    t.string   "lang",                   :limit => 8
    t.text     "settings"
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "host",                   :limit => 100
    t.integer  "memberships_count",                     :default => 0
    t.string   "slug",                   :limit => 100
    t.boolean  "open",                                  :default => true
    t.datetime "last_activity_email_at"
    t.string   "icon_path",              :limit => 100
    t.string   "shelf_name",             :limit => 100
    t.text     "description"
    t.boolean  "visible_on_header",                     :default => false
  end

  add_index "libraries", ["host"], :name => "index_camps_on_host"
  add_index "libraries", ["slug"], :name => "index_camps_on_slug"

  create_table "licenses", :force => true do |t|
    t.string   "name",             :limit => 300
    t.string   "url",              :limit => 500
    t.string   "icon",             :limit => 300
    t.boolean  "open"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "references_count"
    t.string   "image_url",        :limit => 200
    t.string   "slug",             :limit => 300
    t.text     "body"
  end

  create_table "memberships", :force => true do |t|
    t.integer "library_id"
    t.integer "user_id"
  end

  add_index "memberships", ["library_id"], :name => "index_memberships_on_library_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "references", :force => true do |t|
    t.integer  "user_id"
    t.string   "title",          :limit => 300
    t.string   "authors",        :limit => 100
    t.string   "editor",         :limit => 100
    t.text     "description"
    t.string   "url",            :limit => 300
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "comments_count",                 :default => 0
    t.string   "media",          :limit => 1024
    t.string   "media_type",     :limit => 32
    t.string   "date",           :limit => 40
    t.integer  "library_id"
    t.string   "marks",          :limit => 300
    t.integer  "license_id"
    t.integer  "publisher_id"
    t.string   "ref_type",       :limit => 16
    t.string   "archive_slug",   :limit => 100
    t.integer  "group_id"
    t.boolean  "open",                           :default => true
    t.string   "cover_image",    :limit => 300
    t.string   "tag_names",      :limit => 300
  end

  add_index "references", ["library_id"], :name => "index_books_on_camp_id"
  add_index "references", ["user_id"], :name => "index_books_on_user_id"

  create_table "shelf_items", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "reference_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.integer  "library_id"
    t.string   "mark",         :limit => 32
    t.text     "description"
  end

  add_index "shelf_items", ["library_id"], :name => "index_shelf_items_on_camp_id"
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
    t.string   "name",                :limit => 200
    t.string   "slug",                :limit => 50
    t.integer  "references_count",                   :default => 0
    t.integer  "comments_count",                     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "library_id"
    t.string   "color",               :limit => 16
    t.text     "description"
    t.integer  "shelf_members_count",                :default => 0
    t.boolean  "open",                               :default => false
    t.integer  "group_id"
    t.string   "settings",            :limit => 300
    t.boolean  "hidden",                             :default => false
    t.integer  "memberships_count",                  :default => 0
    t.integer  "subscriptions_count",                :default => 0
  end

  add_index "shelves", ["group_id"], :name => "index_shelves_on_group_id"
  add_index "shelves", ["library_id"], :name => "index_shelves_on_camp_id"
  add_index "shelves", ["slug"], :name => "index_shelves_on_slug"
  add_index "shelves", ["user_id"], :name => "index_shelves_on_user_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "shelf_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "subscriptions", ["shelf_id"], :name => "index_subscriptions_on_shelf_id"
  add_index "subscriptions", ["user_id"], :name => "index_subscriptions_on_user_id"

  create_table "taggings", :force => true do |t|
    t.integer "reference_id"
    t.integer "tag_id"
  end

  add_index "taggings", ["reference_id"], :name => "index_taggings_on_reference_id"
  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"

  create_table "tags", :force => true do |t|
    t.string   "name",           :limit => 100
    t.string   "slug",           :limit => 100
    t.integer  "taggings_count",                :default => 0
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name",              :limit => 100
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count",                      :default => 0
    t.datetime "last_login_at"
    t.string   "twitter",           :limit => 150
    t.string   "description",       :limit => 300
    t.string   "slug",              :limit => 100
    t.string   "settings",          :limit => 300
    t.string   "password_digest"
    t.string   "uid_twitter"
    t.string   "uid_facebook"
    t.string   "uid_google"
    t.string   "recovery_code"
    t.boolean  "group",                            :default => false
    t.integer  "memberships_count",                :default => 0
    t.string   "avatar",            :limit => 300
    t.integer  "versions_count",                   :default => 0
    t.boolean  "admin",                            :default => false
  end

  add_index "users", ["slug"], :name => "index_users_on_slug"

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :limit => 40,  :null => false
    t.integer  "item_id",                   :null => false
    t.string   "event",                     :null => false
    t.string   "whodunnit"
    t.string   "title",      :limit => 300
    t.string   "user_name",  :limit => 100
    t.text     "object"
    t.datetime "created_at"
    t.integer  "library_id"
    t.string   "extra",      :limit => 40
    t.integer  "shelf_id"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"
  add_index "versions", ["library_id"], :name => "index_versions_on_camp_id"

end
