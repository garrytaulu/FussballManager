class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :id
      t.integer :blueTeam
      t.integer :redTeam

      t.timestamps
    end
  end
end
