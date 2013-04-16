module ApplicationHelper

  # Sets the title of the page.
  def title(page_title)
    content_for :title, page_title.to_s
  end

  # Generates a select element of players.
  def player_select(resource, object, method, required)
    players = Player.all(:order => 'name')

    collection_select(
        object,
        method,
        players,
        :id,
        :name,
        {:selected => resource[object] && resource[object] || nil, :include_blank => true},
        :required => required
    )
  end
end
