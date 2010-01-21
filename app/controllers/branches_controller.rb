class BranchesController < ApplicationController
  
	before_filter :set_branch, 	:only 		=> [:new, :create]
	before_filter :get_branch, 	:only 		=> [:destroy, :update, :show, :edit]

	def index
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
  end 
  
  def update
  end
  
  def destroy 
  end

private
	
	def get_branch
		@branch = Branch.get(current_user,params)
	end
	
	def set_branch
		@branch = Branch.set(current_user,params)
	end
	
end
