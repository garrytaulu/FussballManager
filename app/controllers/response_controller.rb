class ResponseController < ActionController::Base

  # GET response/player
  def player
    @entity = create_player

    respond
  end

  def game
    @entity = create_game

    respond
  end

  def score
    @entity = Score.new
    @entity.game = create_game
    @entity.player = create_player
    @entity.own_goal = false
    @entity.id = 1
    @entity.created_at = Time.now
    @entity.updated_at = Time.now

    respond
  end

  def game_tally
    @entity = GameTally.new

    respond
  end

  def player_tally
    @entity = PlayerTally.new

    respond
  end

  private

  def respond

    @json = JSON.parse(@entity.to_json)

    attrs = @entity.attributes
    @properties = @json.merge(attrs)

    # get the class names from mapped objects
    if defined?(@entity.reflections)
      @entity.reflections.each do |reflection|
        if @properties[reflection[1].foreign_key]
          @properties[reflection[1].foreign_key] = reflection[1].klass
        end
      end
    end

    @json = JSON.pretty_unparse(@json)

    respond_to do |format|
      format.html do
        render 'index'
      end
    end
  end

  def create_player
    player = Player.new

    player.name = 'full name'
    player.nickname = 'nick name'
    player.id = '1'
    player.created_at = Time.now
    player.updated_at = Time.now
    player.avatar = player_path(1) + '/avatar'
    player
  end

  def create_game
    game = Game.new
    game.created_at = Time.now
    game.updated_at = Time.now
    game.blueAttacker = create_player
    game.blueDefender = create_player
    game.redAttacker = create_player
    game.redDefender = create_player
    game.blueTeamScore = 0
    game.redTeamScore = 0
    game.id = 1
    game.status = 'started'
    game
  end
end