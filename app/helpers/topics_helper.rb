module TopicsHelper
	
	def follow_topic
		if @user.following? @topic
			link_to "Stop Following", stop_following_topic_path(@topic), :class => "right metal"
		else
			link_to "Follow", follow_topic_path(@topic), :class =>  "right metal"
		end
	end
	
end
