class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :id
      t.integer :game
      t.integer :player

      t.timestamps
    end
  end
end
