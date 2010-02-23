class CommentsController < ApplicationController
	
	before_filter :set_comment, :only => [:create,:new]
	
	parent_resources :activity, :topic

  def new
  end

	def create
		if @comment.save
			flash[:notice] = "Comment posted succesfully!"
		  render :partial => "comments/ui/post", :locals => {:comment => @comment}
		end
	end
	
private

	def set_comment
		@parent 	= parent_object
		@comment 	= Comment.set(@parent, current_user, params)
	end

end
