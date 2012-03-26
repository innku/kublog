class CreateKublogInvitedAuthors < ActiveRecord::Migration
  def change
    create_table :kublog_invited_authors do |t|
      t.string :name
      t.string :email
      t.references :post
    end
    add_index :kublog_invited_authors, :post_id
  end
end
