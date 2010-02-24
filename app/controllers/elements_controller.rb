class ElementsController < ApplicationController
	
	before_filter :set_element, :only => [:create]
	before_filter	:get_topic, 	:only => [:index,:create,:topic]
	
	def index
		@element_types = ElementType.find(:all).collect{|et| et unless @topic.element_types.include? et }.compact
		render :layout => false
	end
	
	def create
		if @topic.attach @element
			render :text => "Test"
		end 
	end
	
	def destroy 
	  @element.destroy
		render :noting => true
	end
	
private

	def get_topic
		@topic = Topic.find(params[:topic_id])
	end
	
	def get_type
		@type	= ElementType.find(params[:type_id])
	end
	
	def set_element
		get_type
		@element = Element.set(@type, current_user, params)
	end
	
end
