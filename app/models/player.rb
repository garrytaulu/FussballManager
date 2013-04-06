class Player < ActiveRecord::Base
  attr_accessible :avatar, :id, :name, :nickname

  has_many :games
  has_many :scores
end
