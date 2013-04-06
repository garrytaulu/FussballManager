module ApplicationHelper

  # Generates a select element of players
  def player_select(resource, object, method)
    players = Player.all

    collection_select(
        object,
        method,
        players,
        :id,
        :name,
        :selected => resource[method] && resource[method] || '',
        :include_blank => true
    )
  end
end
