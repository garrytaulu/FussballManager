class Score < ActiveRecord::Base
  attr_accessible :game, :id, :player, :own_goal

  belongs_to :game, :class_name => 'Game', :foreign_key => 'game'
  belongs_to :player, :class_name => 'Player', :foreign_key => 'player'

end
