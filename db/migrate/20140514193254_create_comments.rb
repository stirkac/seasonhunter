class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :message
      t.integer :show_id
      t.integer :season
      t.integer :episode # 0 = Season comment
      t.integer :user_id

      t.timestamps
    end

    add_index :comments, :user_id

  end
end
