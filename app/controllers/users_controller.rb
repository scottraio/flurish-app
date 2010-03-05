class UsersController < ApplicationController
	
	before_filter :authenticated?, 	:except 	=> [:login,:logout,:reset_password,:forgot_password]
	before_filter :set_user, 				:only 		=> [:new, :create]
	before_filter :get_user, 				:only 		=> [:index, :follow, :stop_following, :destroy, :update, :show, :edit]

	def follow
		# @user is the user who wishes to follow the user with id = params[:id]
		@user.follow User.find(params[:id])
		redirect_to users_url
	end
	
	def stop_following
		# @user is the user who wishes to stop following the user with id = params[:id]
		@user.stop_following User.find(params[:id])
		redirect_to users_url
	end
	
	def clear_status
	  @user = User.get(current_user,params)
	  @user.update_attributes(:has_status => 0)
	  redirect_to root_url
	end
	
	def index
		@users = User.find_all_by_organization_id(current_user.organization_id, :conditions => ["users.id != ?", current_user.id])
	end
	
	def new
	end
	
	def create
	end
	
	def show
		@activities = @user.feed
	end
	
	def edit
	end
	
	def update
		if @user.update_attributes(params[:user])
			flash[:notice] = "Profile saved successfully"
			redirect_to user_path(@user)
		else
			@errors = @user.errors
			render :edit
		end
	end
	
	def destroy
	end
	
	def login    
	end
	
	def logout
		reset_session
		flash[:notice] = "You have been logged out."
		redirect_to root_path
	end
	
	def forgot_password 
		
	end
	
	def reset_password
	  redirect_to root_path
	end
	
private
	
	def set_user
		@user = User.set(current_user,params)
	end
	
	def get_user
		# The @user is always assumed to be the user who is logged in 
		@user = User.get(current_user,params)
	end
	
end
