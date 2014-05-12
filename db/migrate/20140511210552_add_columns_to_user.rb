class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :image_url, :string
    add_column :users, :gender, :string
  end
end
