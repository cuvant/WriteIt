class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.text :description
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :user

      t.timestamps null: false
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
