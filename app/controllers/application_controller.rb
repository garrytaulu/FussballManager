require "json_responder"

class ApplicationController < ActionController::Base
  self.responder = JsonResponder

  protect_from_forgery
end
