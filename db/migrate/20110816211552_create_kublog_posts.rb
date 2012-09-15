class CreateKublogPosts < ActiveRecord::Migration
  
  def change
    create_table :kublog_posts do |t|
      t.string      :title
      t.text        :body
      t.references  :user, :polymorphic => true
      t.references  :category
      t.string      :slug
      t.timestamps
    end
    
    add_index :kublog_posts, :title
    add_index :kublog_posts, :user_id
    add_index :kublog_posts, :category_id
    add_index :kublog_posts, :slug, :unique => true
  end
end

