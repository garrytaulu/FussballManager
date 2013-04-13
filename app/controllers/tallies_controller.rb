class TalliesController < ApplicationController

  # GET games/1/tallies
  # GET games/1/tallies.json
  def game_index
    game = Game.find(params[:game_id])
    scores = Score.find_all_by_game(game.id, :order => 'created_at asc')
    @tallies = GameTally.new(scores)

    respond_with @tallies
  end

  # GET players/1/tallies
  # GET players/1/tallies.json
  def player_index
    player = Player.find(params[:player_id])
    scores = Score.find_all_by_player(player.id, :order => 'game, created_at asc')
    @tallies = PlayerTally.new(player, scores)

    respond_with @tallies
  end
end
