class CreateKublogPosts < ActiveRecord::Migration
  def change
    create_table :kublog_posts do |t|
      t.string      :title
      t.text        :body
      t.boolean     :email_notify, :default => false
      t.text        :email_body
      t.integer     :users_notified
      t.boolean     :twitter_notify, :default => false
      t.string      :tweet_id
      t.string      :tweet_text
      t.boolean     :facebook_notify, :default => false
      t.text        :facebook_text
      t.references  :user
      t.references  :category
      t.string      :intended_for
      t.string      :slug
      t.timestamps
    end
    
    add_index :kublog_posts, :title
    add_index :kublog_posts, :user_id
    add_index :kublog_posts, :category_id
    add_index :kublog_posts, :slug, :unique => true
  end
end

