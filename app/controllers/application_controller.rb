# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

	include LoginSystem
	
	before_filter :authenticated?
	
	helper_method :current_user, :logged_in?

	layout "default"

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
