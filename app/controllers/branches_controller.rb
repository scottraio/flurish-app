class BranchesController < ApplicationController
  
  before_filter :get_user, 				:only 		=> [:destroy, :update, :show, :edit]
  	
  def show
  
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end

private
	
	def get_user
		@user = User.get(current_user,params)
	end
end
