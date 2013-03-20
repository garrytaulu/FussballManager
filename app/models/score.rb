class Score < ActiveRecord::Base
  attr_accessible :game, :id, :player

  belongs_to :game, :class_name => 'Game', :foreign_key => 'game'
  belongs_to :player, :class_name => 'Player', :foreign_key => 'player'

  # properties used for the selected state of the form drop downs
  attr_accessor :selected_game
  attr_accessor :selected_player
end
