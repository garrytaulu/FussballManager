class GameStatus < ActiveRecord::Migration
  add_column :games, :status, :string, :default => 'created'
end
