class BranchesController < ApplicationController
  
	before_filter :set_branch, 	:only 		=> [:new, :create]
	before_filter :get_branch, 	:only 		=> [:follow, :stop_following, :destroy, :update, :show, :edit]

	def follow
		# @user is the user who wishes to follow the user with id = params[:id]
		@user.follow @branch
		redirect_back 
	end
	
	def stop_following
		# @user is the user who wishes to stop following the user with id = params[:id]
		@user.stop_following @branch
		redirect_back
	end

	def index
		get_user
		@branches = Branch.find_all_by_organization_id(current_user.organization_id)
	end

  def new
  end
  
  def create
		if @branch.save
			flash[:notice] = "#{@branch.name} created successfully"
			redirect_to branch_path(@branch)
		else
			flash[:error] = @branch.errors
			render :new
		end
  end	
  	
  def show
  end
  
  def edit 
		@element_types = ElementType.find :all
  end 
  
  def update
  end
  
  def destroy 
  end

private
	
	def get_branch
		get_user
		@branch = Branch.get(current_user,params)
	end
	
	def set_branch
		get_user
		@branch = Branch.set(current_user,params)
	end
	
	def get_user
		@user = User.get(current_user,params)
	end
	
end
