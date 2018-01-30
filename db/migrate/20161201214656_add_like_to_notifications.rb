class AddLikeToNotifications < ActiveRecord::Migration
  def change
    add_reference :notifications, :like, index: true
  end
end
