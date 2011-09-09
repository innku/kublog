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

ActiveRecord::Schema.define(:version => 20110901205127) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "kublog_categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kublog_categories", ["name"], :name => "index_kublog_categories_on_name"
  add_index "kublog_categories", ["slug"], :name => "index_kublog_categories_on_slug", :unique => true

  create_table "kublog_comments", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "author_name"
    t.string   "author_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kublog_comments", ["post_id"], :name => "index_kublog_comments_on_post_id"
  add_index "kublog_comments", ["user_id"], :name => "index_kublog_comments_on_user_id"

  create_table "kublog_images", :force => true do |t|
    t.string   "alt"
    t.string   "file"
    t.integer  "file_width"
    t.integer  "file_height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kublog_notifications", :force => true do |t|
    t.string   "kind"
    t.text     "content"
    t.integer  "provider_id"
    t.integer  "post_id"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.text     "roles"
    t.integer  "times_delivered", :default => 0
  end

  add_index "kublog_notifications", ["kind"], :name => "index_kublog_notifications_on_kind"
  add_index "kublog_notifications", ["post_id"], :name => "index_kublog_notifications_on_post_id"

  create_table "kublog_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.integer  "user_id"
    t.integer  "category_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kublog_posts", ["category_id"], :name => "index_kublog_posts_on_category_id"
  add_index "kublog_posts", ["slug"], :name => "index_kublog_posts_on_slug", :unique => true
  add_index "kublog_posts", ["title"], :name => "index_kublog_posts_on_title"
  add_index "kublog_posts", ["user_id"], :name => "index_kublog_posts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
