class TalliesController < ApplicationController

  # GET games/1/tallies
  # GET games/1/tallies.json
  def game_index
    game = Game.find(params[:game_id])
    scores = Score.find_all_by_game(game.id, :order => 'created_at asc')
    @tallies = GameTally.new(scores)

    respond_to do |format|
      format.html do
        respond_with @tallies
      end
      format.json do
        render :json => @tallies.as_json(:only => params[:only])
      end
    end
  end

  # GET players/1/tallies
  # GET players/1/tallies.json
  def player_index
    player = Player.find(params[:player_id])
    scores = Score.find_all_by_player(player.id)
    @tallies = PlayerTally.new(player, scores)

    respond_to do |format|
      format.html do
        respond_with @tallies
      end
      format.json do
        render :json => @tallies.as_json(:only => params[:only])
      end
    end
  end
end
