class ElementsController < ApplicationController
	
	before_filter :set_element, :only => [:create]
	before_filter	:get_topic, 	:only => [:index,:create]
	
	def index
		@element_types = ElementType.find(:all).collect{|et| et unless @branch.element_types.include? et }.compact
		render :layout => false
	end
	
	def create
		if @branch.attach @element
			render :text => "Test"
		end 
	end
	
	def destroy 
	  
	end
	
private

	def get_topic
		@branch 	= Topic.find(params[:branch_id])
	end
	
	def set_element
		@type			= ElementType.find(params[:type_id])
		@element 	= Element.set(@type, current_user, params)
	end
	
end
