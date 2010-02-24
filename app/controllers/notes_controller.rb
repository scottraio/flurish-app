class NotesController < ApplicationController
	
	before_filter :get_topic_and_element
	before_filter :set_note, :only => [:new,:create]
	before_filter :get_note, :only => [:edit,:update]
	
	def new
		render :layout => false
	end
	
	def create
		if @note.save
			render_index
		end
	end
	
	def edit
		render :layout => false
	end
	
	def update
		if @note.save
			render_index
		end
	end
	
private

	def render_index
		render(:partial => "notes/index", :locals => {:element => @element})
	end

	def get_topic_and_element
		@topic 		= Topic.get(current_user,params)
		@element	= Element.find(params[:element_id])
	end
	
	def set_note
		@note = Note.set(@element,current_user,params)
	end
	
	def get_note
		@note = Note.get(@element,current_user,params)
	end
	
end
