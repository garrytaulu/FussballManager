class WallsController < ApplicationController
  # GET /walls
  # GET /walls.json
  def index
    @wallFame = []
    @people = []

    # WALL OF FAME CATEGORIES
    @people = getPeopleFromResult(getMgScoredAttQuery)
    wallCat_MG_S_ATT = WallCategory.new('Most goals scored as an attacker', 'FAME', @people)

    @people = getPeopleFromResult(getMgScoredDefQuery)
    wallCat_MG_S_DEF = WallCategory.new('Most goals scored as a defender', 'FAME', @people)

    @people = getPeopleFromResult(getLgReceivedDefQuery)
    wallCat_LG_S_DEF = WallCategory.new('Least goals received as a defender', 'FAME', @people)

    # WALL OF SHAME CATEGORIES
    @people = getPeopleFromResult(getMgReceivedDefQuery)
    wallCat_MG_R_DEF = WallCategory.new('Least goals received as a defender', 'SHAME', @people)

    @people = getPeopleFromResult(getMogScoredQuery)
    wallCat_MOG = WallCategory.new('Most own goals scored', 'SHAME', @people)

    #append all generated categories to response object
    @wallFame.append(wallCat_MG_S_ATT)
    @wallFame.append(wallCat_MG_S_DEF)
    @wallFame.append(wallCat_LG_S_DEF)
    @wallFame.append(wallCat_MG_R_DEF)
    @wallFame.append(wallCat_MOG)

    respond_with @wallFame
  end

  def getPeopleFromResult(query)
    people = []
    sqlResult = Score.find_by_sql(query)

    sqlResult.each do |person|
      if (people.length < 2)
        if (person.goals.to_i > 0)
          wallPerson = WallPerson.new('', person.nickname, 'SHOTS!!!', person.goals)
          people.append(wallPerson)
        end
      end
    end

    return people
  end

  def getMgScoredAttQuery
    return 'SELECT p0.nickname,
           (
             SELECT COUNT(s.id)
             FROM scores s, games g
             WHERE s.game = g.id
             AND s.player = p0.id
             AND (g."blueAttacker" = p0.id OR g."redAttacker" = p0.id)
             AND s.own_goal = false
           ) goals
    FROM players p0
    ORDER BY goals DESC'
  end

  def getMgScoredDefQuery
    return 'SELECT p0.nickname,
           (
             SELECT COUNT(s.id)
             FROM scores s, games g
             WHERE s.game = g.id
             AND s.player = p0.id
             AND (g."blueDefender" = p0.id OR g."redDefender" = p0.id)
             AND s.own_goal = false
           ) goals
    FROM players p0
    ORDER BY goals DESC'
  end

  def getLgReceivedDefQuery
    return 'SELECT p0.nickname,
           (
             SELECT COUNT(s.id)
             FROM scores s, games g
             WHERE s.game = g.id
             AND s.player <> p0.id
             AND
             (
                (g."blueDefender" = p0.id AND s.player <> g."blueAttacker")
                OR
                (g."redDefender" = p0.id AND s.player <> g."redAttacker")
             )
             AND s.own_goal = false
           ) goals
    FROM players p0
    ORDER BY goals ASC'
  end

  def getMgReceivedDefQuery
    return 'SELECT p0.nickname,
           (
             SELECT COUNT(s.id)
             FROM scores s, games g
             WHERE s.game = g.id
             AND s.player <> p0.id
             AND
             (
                (g."blueDefender" = p0.id AND s.player <> g."blueAttacker")
                OR
                (g."redDefender" = p0.id AND s.player <> g."redAttacker")
             )
             AND s.own_goal = false
           ) goals
        FROM players p0
        ORDER BY goals DESC'
  end

  def getMogScoredQuery
    return 'SELECT p0.nickname,
        (
           SELECT COUNT(s.id)
           FROM scores s, games g
           WHERE s.game = g.id
           AND s.player = p0.id
           AND s.own_goal = true
         ) goals
        FROM players p0
        ORDER BY goals DESC'
  end

end
