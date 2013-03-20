class Game < ActiveRecord::Base
  attr_accessible :blueTeam, :id, :redTeam

  belongs_to :blueTeam, :class_name => 'Team', :foreign_key => 'blueTeam'
  belongs_to :redTeam, :class_name => 'Team', :foreign_key => 'redTeam'

  has_many :scores

  # properties used for the selected state of the form drop downs
  attr_accessor :selected_blue_team
  attr_accessor :selected_red_team
end
