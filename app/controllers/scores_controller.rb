class ScoresController < ApplicationController

  respond_to :html, :json, :xml

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all

    respond_with @scores
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
    @score = Score.find(params[:id])

    respond_with @score
  end

  # GET /scores/new
  # GET /scores/new.json
  def new
    @score = Score.new
    @games = Game.all
    @players = Player.all
  end

  # GET /scores/1/edit
  def edit
    @score = Score.find(params[:id])
    @score.selected_game = @score.game.id
    @score.selected_player = @score.player.id

    @games = Game.all
    @players = Player.all
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new()
    @score.game = Game.find(params[:score][:selected_game])
    @score.player = Player.find(params[:score][:selected_player])

    @score.save

    respond_with @score
  end

  # PUT /scores/1
  # PUT /scores/1.json
  def update
    @score = Score.find(params[:id])
    @score.game = Game.find(params[:score][:selected_game])
    @score.player = Player.find(params[:score][:selected_player])

    @score.save

    respond_with @score
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score = Score.find(params[:id])
    @score.destroy

    respond_with @score
  end
end
