class AddNumberToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :number, :integer
  end
end
