class TeamsController < ApplicationController

  respond_to :html, :json, :xml

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all(:joins => [:offense, :defense])

    respond_with @teams
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id], :joins => [:offense, :defense])

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
    @players = Player.all
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(params[:team])
    @team.save

    respond_with @team
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])
    @team.update_attributes(params[:team])

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
