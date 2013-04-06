class GamesController < ApplicationController

  respond_to :html, :json, :xml

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

    @teams = Team.all
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
    @game.blueTeam = @game.blueTeam.id
    @game.redTeam  = @game.redTeam.id

    @teams = Team.all
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new
    @game.blueTeam = Team.find(params[:game][:blueTeam])
    @game.redTeam = Team.find(params[:game][:redTeam])

    @game.save

    respond_with @game
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id])
    @game.blueTeam = Team.find(params[:game][:blueTeam])
    @game.redTeam = Team.find(params[:game][:redTeam])

    @game.save

    respond_with @game
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_with @game
  end
end