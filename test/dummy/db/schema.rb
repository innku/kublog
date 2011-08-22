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

ActiveRecord::Schema.define(:version => 20110819135547) do

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

  create_table "kublog_images", :force => true do |t|
    t.string   "alt"
    t.string   "file"
    t.integer  "file_width"
    t.integer  "file_height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kublog_posts", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.boolean  "email_notify",    :default => false
    t.text     "email_body"
    t.integer  "users_notified"
    t.boolean  "twitter_notify",  :default => false
    t.string   "tweet_id"
    t.string   "tweet_text"
    t.boolean  "facebook_notify", :default => false
    t.text     "facebook_text"
    t.integer  "user_id"
    t.string   "intended_for"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
  end

  add_index "kublog_posts", ["category_id"], :name => "index_kublog_posts_on_category_id"
  add_index "kublog_posts", ["slug"], :name => "index_kublog_posts_on_slug", :unique => true
  add_index "kublog_posts", ["title"], :name => "index_kublog_posts_on_title"
  add_index "kublog_posts", ["user_id"], :name => "index_kublog_posts_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
