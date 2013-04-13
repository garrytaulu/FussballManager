require "json_responder"

class ApplicationController < ActionController::Base
  self.responder = JsonResponder

  protect_from_forgery

  # all controllers respond to html and json.
  respond_to :html, :json

  # handler for 404 exceptions
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def record_not_found

    respond_to do |format|
      format.html do
        render :status => :not_found, :text => 'Resource not found'
      end
      format.json do
        render :status => :not_found, :nothing => true
      end
    end
  end
end
