class Mailer < ActionMailer::Base

	template_root = "#{Rails.root}/app/mailers"
	
	
	
	#
	# comment notification is sent out perspective users
	#
	def comment_notification(subject,to,from,comment)
		recipients   to.login
		subject      subject
		from         "notifications@#{DOMAIN}"
		body         :comment => comment, :subject => subject
		content_type "text/html"
  end  
	
	#
	# new topic notification is sent out perspective users
	#
	def topic_notification(topic,user)
		recipients   user.login
		subject      "New topic! #{topic.creator.name} created topic #{topic.name}"
		from         "notifications@#{DOMAIN}"
		body         :topic => topic
		content_type "text/html"
  end
	
	def mailer_name
		""
	end

end
