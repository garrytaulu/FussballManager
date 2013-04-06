class Game < ActiveRecord::Base
  attr_accessible :id, :blueAttacker, :blueDefender, :redAttacker, :redDefender

  belongs_to :blueAttacker, :class_name => 'Player', :foreign_key => 'blueAttacker'
  belongs_to :blueDefender, :class_name => 'Player', :foreign_key => 'blueDefender'
  belongs_to :redAttacker, :class_name => 'Player', :foreign_key => 'redAttacker'
  belongs_to :redDefender, :class_name => 'Player', :foreign_key => 'redDefender'

  has_many :scores
end
