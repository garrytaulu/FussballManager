class TalliesController < ApplicationController

  # GET games/1/tallies
  # GET games/1/tallies.json
  def game_index
    scores = Score.find_all_by_game(params[:game_id], :order => 'created_at asc')
    @tallies = GameTally.new(scores)

    respond_with @tallies
  end

  # GET players/1/tallies
  # GET players/1/tallies.json
  def player_index
    player = Player.find(params[:player_id])
    scores = Score.find_all_by_player(params[:player_id], :order => 'game, created_at asc')
    @tallies = PlayerTally.new(player, scores)

    respond_with @tallies
  end
end
