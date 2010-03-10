class LinksController < ApplicationController
  
  before_filter :get_topic_and_element
  before_filter :set_link, :only => [:new,:create]
	before_filter :get_link, :only => [:edit,:update]
  
  def new
		render :layout => false
	end
	
	def create
		if @link.save
		  render_index
		else
		  flash[:error] = @link.errors
			render :new, :layout => false, :status => 500
		end
	end
	
	def edit
		render :layout => false
	end
	
	def update
		if @link.save
		end
	end
	
	private
	
	def render_index
		render(:partial => "links/index", :locals => {:element => @element})
	end
	
	def get_topic_and_element
		@topic 		= Topic.get(current_user,params)
		@element	= Element.find(params[:element_id])
	end
  
  def get_link
		@link = Link.get(@element,current_user,params)
	end
	
	def set_link
		@link = Link.set(@element,current_user,params)
	end
  
end
