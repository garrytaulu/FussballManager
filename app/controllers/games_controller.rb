class GamesController < ApplicationController

  # GET /games
  # GET /games.json
  def index
    @games = Game.all(:order => 'id')

    @games.each do |game|

      scores = Score.find_all_by_game(game.id)
      tally = GameTally.new(scores)
      game.blueTeamScore = tally.blueTeamTotal
      game.redTeamScore = tally.redTeamTotal

    end

    respond_with @games
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

    scores = Score.find_all_by_game(params[:id])
    tally = GameTally.new(scores)
    @game.blueTeamScore = tally.blueTeamTotal
    @game.redTeamScore = tally.redTeamTotal

    respond_with @game
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new
    @players_count = Player.count
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
    @players_count = Player.count
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new

    @game.status = GameStatusEnum.created
    @game.blueAttacker = Player.find(params[:blueAttacker][:id])
    @game.blueDefender = Player.find(params[:blueDefender][:id])
    @game.redAttacker = Player.find(params[:redAttacker][:id])
    @game.redDefender = Player.find(params[:redDefender][:id])

    if @game.players_are_valid
      @game.save

      respond_to do |format|
        format.html do
          redirect_to game_path(@game)
        end
        format.json do
          render :status => :created,
                 :location => game_path(@game),
                 :json => {:id => @game.id }
        end
      end
    else
      respond_to do |format|
        message = "You can't have the same player on both sides"
        format.html do
          render :status => :bad_request, :text => message
        end
        format.json do
          render :status => :bad_request, :json => {
              :code => 1,
              :message => message
          }
        end
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update

    @game = Game.find(params[:id])

    @game.blueAttacker = Player.find(params[:blueAttacker][:id])
    @game.blueDefender = Player.find(params[:blueDefender][:id])
    @game.redAttacker = Player.find(params[:redAttacker][:id])
    @game.redDefender = Player.find(params[:redDefender][:id])


    if @game.status == GameStatusEnum.finished

      respond_to do |format|
        message = "Can't set status once the game status is 'finished'"
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

      return
    else
      @game.status = params[:status]
    end

    if @game.players_are_valid
      @game.save

      respond_to do |format|
        format.html do
          redirect_to game_path(@game)
        end
        format.json do
          render :nothing => true
        end
      end
    else
      respond_to do |format|
        message = "You can't have the same player on both sides"
        format.html do
          render :status => :bad_request, :text => message
        end
        format.json do
          render :status => :bad_request, :json => {
              :code => 2,
              :message => message
          }
        end
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    scores = Score.find_all_by_game(@game.id)

    if scores.count == 0
      @game.destroy

      respond_to do |format|
        format.html do
          redirect_to games_path
        end
        format.json do
          render :nothing => true
        end
      end
    else
      respond_to do |format|
        format.html do
          redirect_to games_path
        end
        format.json do
          render :status => :conflict, :json => {
              :code => 1,
              :message => "Can't remove this game because it has scores"
          }
        end
      end
    end
  end
end