require "json_responder"

class ApplicationController < ActionController::Base
  self.responder = JsonResponder

  protect_from_forgery

  # all controllers respond to html, json and xml.
  respond_to :html, :json, :xml
end
