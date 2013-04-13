class ScoresController < ApplicationController

  # GET games/1/scores
  # GET games/1/scores.json
  def index
    game = Game.find(params[:game_id])
    @scores = Score.find_all_by_game(game.id, :order => 'created_at')

    respond_with @scores
  end

  # GET games/1/scores/1
  # GET games/1/scores/1.json
  def show
    @score = Score.find(params[:id])

    respond_to do |format|
      format.html
      format.json do
        render :json => @score
      end
    end
  end

  # GET games/1/scores/new
  def new
    @score = Score.new
    @score.game = Game.find(params[:game_id])

    respond_to do |format|
      format.html
      format.json do
        render :status => :not_found
      end
    end
  end

  # GET games/1/scores/1/edit
  def edit
    @score = Score.find(params[:id])

    respond_to do |format|
      format.html
      format.json do
        render :status => :not_found
      end
    end
  end

  # POST games/1/scores
  # POST games/1/scores.json
  def create
    @score = Score.new
    @score.game = Game.find(params[:game_id])
    @score.player = Player.find(params[:score][:player])
    @score.own_goal = params[:score][:own_goal]

    set_team(@score)
    @score.save

    respond_to do |format|
      format.html do
        redirect_to game_score_path([@score.game, @score])
      end
      format.json do
        render :status => :created,
               :location => game_score_path(@score.game, @score),
               :json => {:id => @score.id }
      end
    end
  end

  # PUT games/1/scores/1
  # PUT games/1/scores/1.json
  def update
    @score = Score.find(params[:id])
    @score.player = Player.find(params[:score][:player])
    @score.own_goal = params[:score][:own_goal]

    set_team(@score)
    @score.save

    respond_to do |format|
      format.html do
        redirect_to game_score_path(@score.game, @score)
      end
      format.json do
        render :nothing => true
      end
    end
  end

  # DELETE games/1/scores/1
  # DELETE games/1/scores/1.json
  def destroy
    @score = Score.find(params[:id])
    @score.destroy

    respond_to do |format|
      format.html do
        redirect_to game_scores_path
      end
      format.json do
        render :nothing => true
      end
    end
  end

  private

  def set_team(score)

    return unless score

    # work out which team scored by first
    # checking if its a blue player
    flag = score.player.id == score.game.blueAttacker.id ||
        score.player.id == score.game.blueDefender.id

    # if it's an own goal then flip flag otherwise do nothing
    flag = score.own_goal && !flag

    if flag
      score.team = 'blue'
    else
      score.team = 'red'
    end
  end
end
