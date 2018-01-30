class AddFollowingIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :follow_id, :integer
    
    add_index :notifications, :follow_id
  end
end
