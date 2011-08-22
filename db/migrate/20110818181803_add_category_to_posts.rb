class AddCategoryToPosts < ActiveRecord::Migration
  def change
    change_table :kublog_posts do |t|
      t.references :category
    end
    add_index :kublog_posts, :category_id
  end
end
