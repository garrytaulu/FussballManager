class Team < ActiveRecord::Base
  attr_accessible :id, :name, :offense, :defense

  belongs_to :offense, :class_name => 'Player', :foreign_key => 'offense'
  belongs_to :defense, :class_name => 'Player', :foreign_key => 'defense'

  has_many :games

  # properties used for the selected state of the form drop downs
  attr_accessor :selected_offense
  attr_accessor :selected_defense
end
