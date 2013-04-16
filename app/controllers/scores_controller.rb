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
    # if the game is not found then this will cause a 404
    # instead of return the score with matching id.
    Game.find(params[:game_id])

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
  end

  # GET games/1/scores/1/edit
  def edit
    @score = Score.find(params[:id])
  end

  # POST games/1/scores
  # POST games/1/scores.json
  def create

    game = Game.find(params[:game_id])

    if game.status == GameStatusEnum.started
      @score = Score.new
      @score.game = game
      @score.player = Player.find(params[:player][:id])
      @score.own_goal = params[:own_goal]

      @score.save

      respond_to do |format|
        format.html do
          redirect_to game_score_path(@score.game, @score)
        end
        format.json do
          render :status => :created,
                 :location => game_score_path(@score.game, @score),
                 :json => {:id => @score.id }
        end
      end
    else
      respond_to do |format|
        message = "You can't create scores for this game until it's status is started"
        format.html do
          render :status => :conflict, :text => message
        end
        format.json do
          render :status => :conflict, :json => {
              :code => 1,
              :message => message
          }
        end
      end
    end
  end

  # PUT games/1/scores/1
  # PUT games/1/scores/1.json
  def update
    game = Game.find(params[:game_id])

    if game.status == GameStatusEnum.started
      @score = Score.find(params[:id])
      @score.player = Player.find(params[:player][:id])
      @score.own_goal = params[:own_goal]

      @score.save

      respond_to do |format|
        format.html do
          redirect_to game_score_path(@score.game, @score)
        end
        format.json do
          render :nothing => true
        end
      end
    else
      respond_to do |format|
        message = 'You can only update a score if the game status is started'
        format.html do
          render :status => :conflict, :text => message
        end
        format.json do
          render :status => :conflict, :json => {
              :code => 1,
              :message => message
          }
        end
      end
    end
  end

  # DELETE games/1/scores/1
  # DELETE games/1/scores/1.json
  def destroy
    game = Game.find(params[:game_id])

    if game.status == GameStatusEnum.started
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
    else
      respond_to do |format|
        message = 'You can only remove scores when the game status is started'
        format.html do
          render :status => :conflict, :text => message
        end
        format.json do
          render :status => :conflict, :json => {
              :code => 1,
              :message => message
          }
        end
      end
    end
  end
end
