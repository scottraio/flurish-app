module ActivitiesHelper
	
	def explanation_of(activity)
		@activity = activity
		case which 
			when :status 
				render_explanation status_in_words(@activity.activible)
			when :comment 
				render_explanation comment_in_words(@activity.activible)
		end
	end
	
	def which
		if 			@activity.activible.is_a? Status 		then :status
		elsif 	@activity.activible.is_a? Comment 	then :comment
		end
	end
	
	#
	# Explanations of various activities
	# 
	# renders avatar and username with custome text and actions 
	# ie:// activible( stamp( text, actions ) )
	#
	
	# Builder methods
	
	def render_explanation(method)
		content_tag "div", method, :class => "activity"
	end
	
	def activible(stamped)
		content_tag :div, :class => "activible", :style => "background:url(#{avatar_url(@activity.creator, :thumb)}) no-repeat" do 
			stamped
		end
	end
	
	def stamp(text,actions="")
		content_tag :div, :class => "stamp" do 
			"<b>" + (link_to @activity.creator.name, "/users/#{@activity.creator.id}") + "</b>" + " " + text + ago(actions)
		end
	end
	
	def ago(actions)
		content_tag(:div, time_ago_in_words(@activity.created_at) + " ago " + actions, :class => "metadata")
	end
	
	# Status
		
	def status_in_words(status) 
		actions = link_to("Comment", "#", :id => "comments_#{@activity.id}", :class => "comment_link")
 		activible stamp(status.message,actions)
	end
	
	# Branch Comments
	
	def comment_in_words(comment) 
 		activible stamp(" > " +  image_tag('/images/icons/topic16x16.png') + " " + link_to(@activity.branch.name, branch_path(@activity.branch)) + " " + comment.message)
	end
	
end
