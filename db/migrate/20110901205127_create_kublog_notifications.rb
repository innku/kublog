class CreateKublogNotifications < ActiveRecord::Migration
  def change
    
    create_table :kublog_notifications do |t|
      t.string      :kind
      t.text        :content
      t.integer     :provider_id
      t.references  :post
      t.datetime    :sent_at
      t.datetime    :created_at
      t.text        :roles
      t.integer     :times_delivered, :default => 0
    end
    
    add_index :kublog_notifications, :kind
    add_index :kublog_notifications, :post_id
  end
end
