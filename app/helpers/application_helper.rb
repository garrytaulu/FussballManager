module ApplicationHelper

  # Sets the title of the page.
  def title(page_title)
    content_for :title, page_title.to_s
  end

  # Generates a select element of players.
  def player_select(resource, object, method, required)
    players = Player.all

    collection_select(
        object,
        method,
        players,
        :id,
        :name,
        {:selected => resource[method] && resource[method] || nil, :include_blank => true},
        :required => required
    )
  end
end
