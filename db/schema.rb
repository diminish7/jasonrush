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

ActiveRecord::Schema.define(:version => 20130112191643) do

  create_table "blogs", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "blogs", ["name"], :name => "index_blogs_on_name", :unique => true

  create_table "comments", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.text     "comment"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.boolean  "active",           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], :name => "index_comments_on_commentable_id_and_commentable_type"
  add_index "comments", ["created_at"], :name => "index_comments_on_created_at"
  add_index "comments", ["email"], :name => "index_comments_on_email"

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "author_id"
    t.integer  "blog_id"
    t.string   "cached_slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["blog_id"], :name => "index_posts_on_blog_id"
  add_index "posts", ["created_at"], :name => "index_posts_on_created_at"
  add_index "posts", ["title"], :name => "index_posts_on_title"

  create_table "slugs", :force => true do |t|
    t.string   "name"
    t.integer  "sluggable_id"
    t.integer  "sequence",                     :default => 1, :null => false
    t.string   "sluggable_type", :limit => 40
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "slugs", ["name", "sluggable_type", "sequence", "scope"], :name => "index_slugs", :unique => true
  add_index "slugs", ["sluggable_id"], :name => "index_slugs_on_sluggable_id"

  create_table "users", :force => true do |t|
    t.string   "first_name",          :limit => 100
    t.string   "last_name",           :limit => 100
    t.string   "email",               :limit => 100
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",                 :default => "", :null => false
    t.datetime "remember_created_at"
  end

end
