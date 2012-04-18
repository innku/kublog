class CreateKublogComments < ActiveRecord::Migration
  def change
    create_table :kublog_comments do |t|
      t.text       :body
      t.references :user, :polymorphic => true
      t.references :post
      t.string     :author_name
      t.string     :author_email
      t.timestamps
    end
    add_index :kublog_comments, :post_id
    add_index :kublog_comments, :user_id
  end
end
