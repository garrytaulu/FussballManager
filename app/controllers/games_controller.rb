class GamesController < ApplicationController

  # GET /games
  # GET /games.json
  def index
    @games = Game.all

    respond_with @games
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id])

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

    @game.blueAttacker = Player.find(params[:blueAttacker][:id])
    @game.blueDefender = Player.find(params[:blueDefender][:id])
    @game.redAttacker = Player.find(params[:redAttacker][:id])
    @game.redDefender = Player.find(params[:redDefender][:id])

    @game.save

    respond_with @game
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    @game.blueAttacker = Player.find(params[:blueAttacker][:id])
    @game.blueDefender = Player.find(params[:blueDefender][:id])
    @game.redAttacker = Player.find(params[:redAttacker][:id])
    @game.redDefender = Player.find(params[:redDefender][:id])

    @game.save

    respond_with @game
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
              :message => "Can't remove game because it has scores."
          }
        end
      end
    end
  end
end