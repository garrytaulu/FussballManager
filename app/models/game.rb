class Game < ActiveRecord::Base
  attr_accessible :id, :blueAttacker, :blueDefender, :redAttacker, :redDefender, :status

  validates_inclusion_of :status, :in => %w(created started paused finished)

  belongs_to :blueAttacker, :class_name => 'Player', :foreign_key => 'blueAttacker'
  belongs_to :blueDefender, :class_name => 'Player', :foreign_key => 'blueDefender'
  belongs_to :redAttacker, :class_name => 'Player', :foreign_key => 'redAttacker'
  belongs_to :redDefender, :class_name => 'Player', :foreign_key => 'redDefender'

  has_many :scores

  # checks to see if the same player is on both sides.
  def players_are_valid

    !(self.blueAttacker == self.redAttacker ||
      self.blueAttacker == self.redDefender ||

      self.blueDefender == self.redAttacker ||
      self.blueDefender == self.redDefender ||

      self.redAttacker == self.blueAttacker ||
      self.redAttacker == self.blueDefender ||

      self.redDefender == self.blueAttacker ||
      self.redDefender == self.blueDefender)
  end
end
