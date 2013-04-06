module ScoresHelper
  # Generates a select element of players
  def scores_player_select(game, score, object, method)
    players = [game.blueAttacker, game.blueDefender, game.redAttacker, game.redDefender]

    collection_select(
        object,
        method,
        players,
        :id,
        :name,
        :selected => score[method] && score[method] || '',
        :include_blank => true
    )
  end
end
