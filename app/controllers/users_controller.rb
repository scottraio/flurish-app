class UsersController < ApplicationController
	
	before_filter :authenticated?, 	:except 	=> [:login,:logout,:reset_password,:forgot_password]
	before_filter :set_user, 				:only 		=> [:new, :create]
	before_filter :get_user, 				:only 		=> [:destroy, :update, :show, :edit]
	
	def index
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
		@user = User.get(current_user,params)
	end
	
end
