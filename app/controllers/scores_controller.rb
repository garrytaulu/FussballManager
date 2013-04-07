class ScoresController < ApplicationController

  # GET games/1/scores
  # GET games/1/scores.json
  def index
    @scores = Score.find_all_by_game(params[:game_id])

    respond_with @scores
  end

  # GET games/1/scores/1
  # GET games/1/scores/1.json
  def show
    @score = Score.find(params[:id])

    respond_with @score
  end

  # GET games/1/scores/new
  # GET games/1/scores/new.json
  def new
    @game = Game.find(params[:game_id])
    @score = Score.new
  end

  # GET games/1/scores/1/edit
  def edit
    @score = Score.find(params[:id])
    @game = @score.game
  end

  # POST games/1/scores
  # POST games/1/scores.json
  def create
    @game = Game.find(params[:game_id])
    @score = Score.new
    @score.game = @game
    @score.player = Player.find(params[:score][:player])
    @score.own_goal = params[:score][:own_goal]

    # work out which team scored
    if @score.player.id == @score.game.blueAttacker.id ||
       @score.player == @score.game.blueDefender.id
      @score.team = 'blue'
    else
      @score.team = 'red'
    end

    @score.save

    respond_with [@game, @score]
  end

  # PUT games/1/scores/1
  # PUT games/1/scores/1.json
  def update
    @score = Score.find(params[:id])
    @score.player = Player.find(params[:score][:player])
    @score.own_goal = params[:score][:own_goal]

    # work out which team scored
    if @score.player.id == @score.game.blueAttacker.id ||
        @score.player == @score.game.blueDefender.id
      @score.team = 'blue'
    else
      @score.team = 'red'
    end

    @score.save

    respond_with [@score.game, @score]
  end

  # DELETE games/1/scores/1
  # DELETE games/1/scores/1.json
  def destroy
    @score = Score.find(params[:id])
    @score.destroy

    respond_with [@score.game, @score]
  end
end
