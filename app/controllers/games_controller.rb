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

    # TODO: And a check to make sure the players are unique for the game.

    @game = Game.new

    @game.status = GameStatusEnum.created
    @game.blueAttacker = Player.find(params[:blueAttacker][:id])
    @game.blueDefender = Player.find(params[:blueDefender][:id])
    @game.redAttacker = Player.find(params[:redAttacker][:id])
    @game.redDefender = Player.find(params[:redDefender][:id])

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
  end

  # PUT /games/1
  # PUT /games/1.json
  def update

    # TODO: And a check to make sure the players are unique for the game.

    @game = Game.find(params[:id])

    @game.blueAttacker = Player.find(params[:blueAttacker][:id])
    @game.blueDefender = Player.find(params[:blueDefender][:id])
    @game.redAttacker = Player.find(params[:redAttacker][:id])
    @game.redDefender = Player.find(params[:redDefender][:id])
    @game.status = params[:status]

    @game.save

    respond_to do |format|
      format.html do
        redirect_to game_path(@game)
      end
      format.json do
        render :nothing => true
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
              :message => "Can't remove game because it has scores."
          }
        end
      end
    end
  end

  # games/1/status
  def get_status
    game = Game.find(params[:game_id])

    respond_with do |format|
      format.html do
        render :text => game.status
      end
      format.json do
        render :json => {:status => game.status}
      end
    end
  end

  def update_status
    game = Game.find(params[:game_id])

    status = params[:status]
    unless status && status != GameStatusEnum.created

       game.status = status
       game.save

       respond_with do |format|
         format.html do
           render :nothing => true
         end
         format.json do
           render :nothing => true
         end
       end
    end

    respond_with do |format|
      format.html do
        render :status => :bad_request, :text => 'The status provided is invalid. Only can be: created, started, paused or finished'
      end
      format.json do
        render :status => :bad_request, :json => {
            :code => 1,
            :message => 'The status provided is invalid.'
        }
      end
    end
  end
end