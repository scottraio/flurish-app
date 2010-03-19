class TasksController < ApplicationController

  before_filter :get_topic_and_element
  before_filter :set_task, :only => [:new,:create]
	before_filter :get_task, :only => [:edit,:update,:pickup]

  def new
		render :layout => false
	end

	def create
		if @task.save
		  render_index
		else
		  flash[:error] = @task.errors
			render :new, :layout => false, :status => 500
		end
	end

	def edit
		render :layout => false
	end

	def update
	  if @task.save
	    render_index
	  end
	end
	
	def pickup
	  @task.update_attribute(:assigned_to, current_user.id)
	  render_index
	end
	
	private

	def render_index
		render(:partial => "tasks/index", :locals => {:element => @element})
	end

	def get_topic_and_element
		@topic 		= Topic.get(current_user,params)
		@element	= Element.find(params[:element_id])
	end

private

  def get_task
		@task = Task.get(@element,current_user,params)
	end

	def set_task
		@task = Task.set(@element,current_user,params)
	end

  
  
end
