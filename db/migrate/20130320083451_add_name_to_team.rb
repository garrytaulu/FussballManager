class AddNameToTeam < ActiveRecord::Migration
  add_column :teams, :name, :string
end
