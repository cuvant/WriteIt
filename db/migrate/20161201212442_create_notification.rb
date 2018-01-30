class CreateNotification < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :notified_by_id, index: true, foreign_key: true
      t.references :micropost, index: true, foreign_key: true
      t.references :comment, index: true, foreing_key: true
      t.string :notice_type
      t.boolean :read, :default => false

      t.timestamps null: false
    end
  end
end
