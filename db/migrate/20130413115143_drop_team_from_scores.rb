class DropTeamFromScores < ActiveRecord::Migration
  remove_column :scores, :team
end
