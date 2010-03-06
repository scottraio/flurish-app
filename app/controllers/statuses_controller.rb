class StatusesController < ApplicationController
	
	before_filter :set_status, :only => [:create]
	before_filter :get_status, :only => [:destroy]
	
	def create
		if @status.save
			flash[:notice] = "Status updated"
		else
			flash[:error] = @status.errors
		end
		
		redirect_to user_path(@user)
	end
	
	def destroy
	  @user.update_attributes(:has_status => 0)
		#render :partial => "/statuses/ui/new_status", :layout => false
		redirect_to user_path(@user)
	end
	
private

	def set_status
		@user 	= User.get(current_user,params)
		@status = Status.set(@user,params)
	end
	
	def get_status
		@user 	= User.get(current_user,params)
		@status = Status.get(@user,params)
	end

end
