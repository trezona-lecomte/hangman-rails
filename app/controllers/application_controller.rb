class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordInvalid, with: :go_to_root
  rescue_from ActionController::RoutingError, with: :go_to_root

  protected
    def go_to_root
      #TODO: show errors
      redirect_to root
    end
end
