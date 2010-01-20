module ActivitiesHelper
	
	def explanation_of(activity)
		@activity = activity
		case which 
			when :status 	then render_explanation(status)
			when :comment then comment_in_words
		end
	end
	
	def which
		if @activity.activible.is_a? Status 																				then :status
		elsif not @activity.element.nil? and @activity.activible.is_a? Comment 			then :comment
		elsif not @activity.element.nil? and @activity.activible.is_a? Attachment 	then :attachment
		end
	end
	
	def render_explanation(method)
		content_tag "div", method, :class => "activity"
	end
	
	def stamp(text)
		actions 	= link_to("Comment", "")
		metadata 	= content_tag(:div,time_ago_in_words(@activity.created_at)+" ago "+actions, :class => "metadata")
		content_tag :div, :class => "stamp" do 
			text+metadata
		end
	end
	
	def status
		status = @activity.activible 
 		content_tag :div, :class => "activible" do 
			image_tag(avatar_url(@activity.creator, :thumb), :align => "top", :class => "avatar_thumb") + stamp(status.message)
		end 
	end
	
end
