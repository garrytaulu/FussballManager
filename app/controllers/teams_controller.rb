class TeamsController < ApplicationController

  respond_to :html, :json, :xml

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all

    respond_with @teams
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])

    respond_with @team
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    @players = Player.all
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
    @team.selected_offense = @team.offense.id
    @team.selected_defense = @team.defense.id

    @players = Player.all
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new
    @team.name = params[:team][:name]
    @team.offense = Player.find(params[:team][:selected_offense])
    @team.defense = Player.find(params[:team][:selected_defense])

    @team.save

    respond_with @team
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    @team.name = params[:team][:name]
    @team.offense = Player.find(params[:team][:selected_offense])
    @team.defense = Player.find(params[:team][:selected_defense])

    @team.save

    respond_with @team
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy

    respond_with @team
  end
end
