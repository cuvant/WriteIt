class AddTimelineCoverToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :timeline_cover, :string
  end
end
