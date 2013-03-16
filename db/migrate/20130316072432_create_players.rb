class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :id
      t.string :name
      t.string :nickname
      t.string :avatar

      t.timestamps
    end
  end
end
