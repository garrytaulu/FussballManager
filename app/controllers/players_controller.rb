class PlayersController < ApplicationController

  # GET /players
  # GET /players.json
  def index
    @players = Player.all

    respond_with @players
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_with @player
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(params[:player])
    @player.save

    respond_with @player
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])
    @player.update_attributes(params[:player])

    respond_with @player
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy

    respond_with @player
  end
end
