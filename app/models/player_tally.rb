class PlayerTally
  include ActiveModel::Serializers::JSON

  attr_accessor :totalGoalsScored, :totalGoalsAttacking, :totalGoalsDefending,
                :totalGamesPlayed, :totalGamesAttacking, :totalGamesDefending,
                :totalOwnGoals, :totalOwnGoalsAttacking, :totalOwnGoalsDefending

  def initialize(player, scores)

    # initialize properties with defaults
    self.totalGoalsScored       = 0
    self.totalGoalsAttacking    = 0
    self.totalGoalsDefending    = 0
    self.totalGamesPlayed       = 0
    self.totalGamesAttacking    = 0
    self.totalGamesDefending    = 0
    self.totalOwnGoals          = 0
    self.totalOwnGoalsAttacking  = 0
    self.totalOwnGoalsDefending = 0

    return unless player && scores && scores.count > 0

    # process the list of scores and tally totals
    last_game_processed = 0
    scores.each do |score|

      if score.game.blueAttacker.id == score.player.id ||
         score.game.redAttacker.id == score.player.id

        self.totalGoalsAttacking += 1

        if last_game_processed != score.game.id
          self.totalGamesAttacking += 1
        end

        if score.own_goal
          self.totalOwnGoalsAttacking += 1
        end
      else
        self.totalGoalsDefending += 1

        if last_game_processed != score.game.id
          self.totalGamesDefending += 1
        end

        if score.own_goal
          self.totalOwnGoalsDefending += 1
        end
      end

      last_game_processed = score.game.id
    end

    self.totalOwnGoals = self.totalOwnGoalsAttacking + self.totalOwnGoalsDefending
    self.totalGoalsScored = self.totalGoalsDefending + self.totalGoalsAttacking
    self.totalGamesPlayed = self.totalGamesAttacking + self.totalGamesDefending
  end

  def attributes
    {
        :totalGoalsScored => self.totalGoalsScored,
        :totalGoalsAttacking => self.totalGoalsAttacking,
        :totalGoalsDefending => self.totalGoalsDefending,
        :totalGamesPlayed => self.totalGamesPlayed,
        :totalGamesAttacking => self.totalGamesAttacking,
        :totalGamesDefending => self.totalGamesDefending,
        :totalOwnGoals => self.totalOwnGoals,
        :totalOwnGoalsAttacking => self.totalOwnGoalsAttacking,
        :totalOwnGoalsDefending => self.totalOwnGoalsDefending
    }.inject({}){|memo,(k,v)| memo[k.to_s] = v; memo} # convert keys to string for json
  end

  def as_json(options = {})
    ParamHelper.handle_only_param(options)

    serializable_hash(options)
  end
end