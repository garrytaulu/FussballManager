class AddToScores < ActiveRecord::Migration
  add_column :scores, :own_goal, :boolean
  add_column :scores, :team, :string
end
