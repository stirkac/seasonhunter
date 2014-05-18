class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :show_id
      t.integer :season
      t.integer :episode
      t.integer :user_id
      t.integer :score

      t.timestamps
    end
  end
end
