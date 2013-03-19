class Team < ActiveRecord::Base
  attr_accessible :id, :offense, :defense

  belongs_to :offense, :class_name => 'Player', :foreign_key => 'offense'
  belongs_to :defense, :class_name => 'Player', :foreign_key => 'defense'

end
