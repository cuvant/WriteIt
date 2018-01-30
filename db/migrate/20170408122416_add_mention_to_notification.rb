class AddMentionToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :mention_id, :integer, index: true
  end
end
