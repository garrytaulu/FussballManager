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

    @game.blueAttacker = Player.find(params[:game][:blueAttacker])
    @game.blueDefender = Player.find(params[:game][:blueDefender])
    @game.redAttacker = Player.find(params[:game][:redAttacker])
    @game.redDefender = Player.find(params[:game][:redDefender])

    @game.save

    respond_with @game
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])

    @game.blueAttacker = Player.find(params[:game][:blueAttacker])
    @game.blueDefender = Player.find(params[:game][:blueDefender])
    @game.redAttacker = Player.find(params[:game][:redAttacker])
    @game.redDefender = Player.find(params[:game][:redDefender])

    @game.save

    respond_with @game
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    scores = Score.find_all_by_game(@game.id)

    if scores && scores.count == 0
      @game.destroy
    end

    respond_with @game
  end
end