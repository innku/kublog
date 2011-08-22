class CreateKublogCategories < ActiveRecord::Migration
  def change
    create_table :kublog_categories do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end
    
    add_index :kublog_categories, :name
  end
end
