class JsonResponder < ActionController::Responder
  protected

  # see: http://stackoverflow.com/questions/9953887/simple-respond-with-in-rails-that-avoids-204-from-put#
  # note: the method to register this with rails is different from how its done in the above stack overflow post (that didn't work)

  # simply render the resource even on POST instead of redirecting for ajax
  def api_behavior(error)
    if post?
      display resource, :status => :created
      # render resource instead of 204 no content
    elsif put?
      display resource, :status => :ok
    else
      super
    end
  end
end
