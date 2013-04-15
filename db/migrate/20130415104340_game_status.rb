class GameStatus < ActiveRecord::Migration
  add_column :games, :status, :string
end
