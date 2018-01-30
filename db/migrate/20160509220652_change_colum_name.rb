class ChangeColumName < ActiveRecord::Migration
  def change
    rename_column :microposts, :address, :street
  end
end
