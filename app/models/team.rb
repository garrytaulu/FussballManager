class Team < ActiveRecord::Base
  attr_accessible :defense, :id, :offense
  belongs_to :player
end
