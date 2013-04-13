module ScoresHelper
  # Generates a select element of players
  def scores_player_select(game, score, object, method, required)
    players = [game.blueAttacker, game.blueDefender, game.redAttacker, game.redDefender]

    collection_select(
        object,
        method,
        players,
        :id,
        :name,
        {:selected => score[object] && score[object] || '',
        :include_blank => true},
        :required => required
    )
  end
end
