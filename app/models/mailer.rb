class Mailer < ActionMailer::Base

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
	
	def mailer_name
		""
	end

end
