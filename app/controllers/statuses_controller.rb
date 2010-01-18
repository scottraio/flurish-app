class StatusesController < ApplicationController
	
	before_filter :set_status, :only => [:create]
	
	def create
		if @status.save
			flash[:notice] = "Status updated"
		else
			flash[:error] = @status.errors
		end
		
		redirect_to user_path(@user)
	end
	
private

	def set_status
		@user 	= User.get(current_user,params)
		@status = Status.set(@user,params)
	end

end
