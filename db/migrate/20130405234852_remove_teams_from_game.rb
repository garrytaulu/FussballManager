class RemoveTeamsFromGame < ActiveRecord::Migration
  remove_column :games, :blueTeam
  remove_column :games, :redTeam

  add_column :games, :blueAttacker, :integer
  add_column :games, :blueDefender, :integer
  add_column :games, :redAttacker, :integer
  add_column :games, :redDefender, :integer
end
