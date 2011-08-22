class CreateKublogImages < ActiveRecord::Migration
  def change
    create_table :kublog_images do |t|
      t.string  :alt
      t.string  :file
      t.integer :file_width
      t.integer :file_height
      t.timestamps
    end
  end
end
