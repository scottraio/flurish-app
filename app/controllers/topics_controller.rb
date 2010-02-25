class TopicsController < ApplicationController
  
	before_filter :set_topic, 	:only 		=> [:new, :create]
	before_filter :get_topic, 	:only 		=> [:follow, :stop_following, :destroy, :update, :show, :edit]

	def follow
		# @user is the user who wishes to follow the user with id = params[:id]
		@user.follow @topic
		redirect_back 
	end
	
	def stop_following
		# @user is the user who wishes to stop following the user with id = params[:id]
		@user.stop_following @topic
		redirect_back
	end

	def index
		get_user
		@tags 	= Topic.tag_counts_on(:tags)
		@topics = Topic.get_all(current_user, params)
	end

  def new
  end
  
  def create
		if @topic.save
			flash[:notice] = "#{@topic.name} created successfully"
			redirect_to topic_path(@topic)
		else
			flash[:error] = @topic.errors
			render :new
		end
  end	
  	
  def show
  end

	def edit
		@element_types = ElementType.find(:all)
	end
  
  def update
		params[:topic][:element_type_ids] ||= []
    if @topic.save
			flash[:notice] = "#{@topic.name} updated successfully"
			redirect_to topic_path(@topic)
		else
			flash[:error] = @topic.errors
			render :new
		end
  end
  
  def destroy 
		if @topic.destroy
			redirect_to topics_path
		else
			flash[:error] = @topic.errors
			render :edit
		end
  end

private
	
	def get_topic
		get_user
		@topic = Topic.get(current_user,params)
	end
	
	def set_topic
		get_user
		@topic = Topic.set(current_user,params)
	end
	
	def get_user
		@user = User.get(current_user,params)
	end
	
end
