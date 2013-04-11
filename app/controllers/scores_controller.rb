class ScoresController < ApplicationController

  # GET games/1/scores
  # GET games/1/scores.json
  def index
    @scores = Score.find_all_by_game(params[:game_id], :order => 'created_at')

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
    @score = Score.new
    @score.game = Game.find(params[:game_id])
  end

  # GET games/1/scores/1/edit
  def edit
    @score = Score.find(params[:id])
  end

  # POST games/1/scores
  # POST games/1/scores.json
  def create
    respond_with upsert_score(params)
  end

  # PUT games/1/scores/1
  # PUT games/1/scores/1.json
  def update
    respond_with upsert_score(params)
  end

  # DELETE games/1/scores/1
  # DELETE games/1/scores/1.json
  def destroy
    @score = Score.find(params[:id])
    @score.destroy

    respond_with [@score.game, @score]
  end

  private

  # Inserts or updated a game score.
  def upsert_score(params)

    return unless params

    if params[:id]
      score = Score.find(params[:id])
    else
      score = Score.new
      score.game = Game.find(params[:game_id])
    end

    score.player = Player.find(params[:score][:player])
    score.own_goal = params[:score][:own_goal]

    # work out which team scored by first
    # checking if its a blue player
    flag = score.player.id == score.game.blueAttacker.id ||
           score.player.id == score.game.blueDefender.id

    # if it's an own goal then flip flag otherwise do nothing
    flag = score.own_goal && !flag || flag

    if flag
      score.team = 'blue'
    else
      score.team = 'red'
    end

    score.save

    # TODO: remove this and do it a different way if possible.
    if response.request.headers['CONTENT_TYPE'] == "application/x-www-form-urlencoded"
      [score.game, score]
    else
      score
    end
  end
end
