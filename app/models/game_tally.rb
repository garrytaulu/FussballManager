class GameTally
  include ActiveModel::Serializers::JSON

  attr_accessor :blueTeamTotal, :redTeamTotal, :blueAttackerTotal, :blueDefenderTotal,
                :redAttackerTotal, :redDefenderTotal, :timeTaken, :blueAttackerOwnGoalsTotal,
                :blueDefenderOwnGoalsTotal, :redAttackerOwnGoalsTotal, :redDefenderOwnGoalsTotal,
                :blueTeamOwnGoalsTotal, :redTeamOwnGoalsTotal

  def initialize(scores)

    # initialize properties with defaults
    self.blueTeamTotal             = 0
    self.blueAttackerTotal         = 0
    self.blueDefenderTotal         = 0
    self.redTeamTotal              = 0
    self.redAttackerTotal          = 0
    self.redDefenderTotal          = 0
    self.blueAttackerOwnGoalsTotal = 0
    self.blueDefenderOwnGoalsTotal = 0
    self.redAttackerOwnGoalsTotal  = 0
    self.redDefenderOwnGoalsTotal  = 0
    self.blueTeamOwnGoalsTotal     = 0
    self.redTeamOwnGoalsTotal      = 0
    self.timeTaken                 = '00:00:00'

    return unless scores && scores.count > 0

    # process the list of scores and tally totals

    scores.each do |score|

      if score.game.blueAttacker.id == score.player.id
        self.blueAttackerTotal += 1
        self.blueAttackerOwnGoalsTotal += score.own_goal && 1 || 0
      elsif score.game.blueDefender.id == score.player.id
        self.blueDefenderTotal += 1
        self.blueDefenderOwnGoalsTotal += score.own_goal && 1 || 0
      elsif score.game.redAttacker.id == score.player.id
        self.redAttackerTotal += 1
        self.redAttackerOwnGoalsTotal += score.own_goal && 1 || 0
      else
        self.redDefenderTotal += 1
        self.redDefenderOwnGoalsTotal += score.own_goal && 1 || 0
      end
    end

    self.blueTeamOwnGoalsTotal = self.blueAttackerOwnGoalsTotal + self.blueDefenderOwnGoalsTotal
    self.redTeamOwnGoalsTotal = self.redAttackerOwnGoalsTotal + self.redDefenderOwnGoalsTotal

    blue_difference = self.blueTeamOwnGoalsTotal * -1
    red_difference = self.redTeamOwnGoalsTotal * -1

    self.blueTeamTotal = self.blueAttackerTotal + self.blueDefenderTotal + blue_difference + self.redTeamOwnGoalsTotal
    self.redTeamTotal = self.redAttackerTotal + self.redDefenderTotal + red_difference + self.blueTeamOwnGoalsTotal

    if self.blueTeamTotal < 0
      self.blueTeamTotal = 0
    end
    if self.redTeamTotal < 0
      self.redTeamTotal = 0
    end

    # if there's more that one score then we can work out the
    # total time of the game so far
    if scores.count > 1
      first_time = scores[0].created_at
      last_time = scores[scores.count - 1].created_at

      time = last_time.minus_with_coercion(first_time)

      hours = (time / 3600).to_i
      minutes = (time / 60 - hours * 60).to_i
      seconds = (time - (minutes * 60 + hours * 3600)).to_i

      hours = hours > 9 && hours.to_s || "0" + hours.to_s
      minutes = minutes > 9 && minutes.to_s || "0" + minutes.to_s
      seconds = seconds > 9 && seconds.to_s || "0" + seconds.to_s

      self.timeTaken = hours + ':' + minutes + ':' + seconds
    end
  end

  def attributes
    {
        :blueTeamTotal => self.blueTeamTotal,
        :redTeamTotal => self.redTeamTotal,
        :blueAttackerTotal => self.blueAttackerTotal,
        :blueDefenderTotal => self.blueDefenderTotal,
        :redAttackerTotal => self.redAttackerTotal,
        :redDefenderTotal => self.redDefenderTotal,
        :timeTaken => self.timeTaken,
        :blueAttackerOwnGoalsTotal => self.blueAttackerOwnGoalsTotal,
        :blueDefenderOwnGoalsTotal => self.blueDefenderOwnGoalsTotal,
        :redAttackerOwnGoalsTotal => self.redAttackerOwnGoalsTotal,
        :redDefenderOwnGoalsTotal => self.redDefenderOwnGoalsTotal,
        :blueTeamOwnGoalsTotal => self.blueTeamOwnGoalsTotal,
        :redTeamOwnGoalsTotal => self.redTeamOwnGoalsTotal
    }.inject({}){|memo,(k,v)| memo[k.to_s] = v; memo} # convert keys to string for json
  end

  def as_json(options = {})
    ParamHelper.handle_only_param(options)

    serializable_hash(options)
  end
end