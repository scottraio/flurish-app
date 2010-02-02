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

	def redirect_back 
		redirect_to request.env['HTTP_REFERER']
	end
	
protected

  class << self

    attr_reader :parents

    def parent_resources(*parents)
      @parents = parents
    end

  end

  def parent_id(parent)
    request.path_parameters["#{ parent }_id"]
  end

  def parent_type
    self.class.parents.detect { |parent| parent_id(parent) }
  end

  def parent_class
    parent_type && parent_type.to_s.classify.constantize
  end

  def parent_object
    parent_class && parent_class.find_by_id(parent_id(parent_type))
  end
	
end
