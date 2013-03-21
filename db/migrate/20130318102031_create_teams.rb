class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :id
      t.integer :offense
      t.integer :defense

      t.timestamps
    end
  end
end
