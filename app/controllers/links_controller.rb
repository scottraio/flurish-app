class LinksController < ApplicationController
  
  def new
		render :layout => false
	end
	
	private
  
  def get_link
		@link = Link.get(@element,current_user,params)
	end
	
	def set_note
		@link = Link.set(@element,current_user,params)
	end
  
end
