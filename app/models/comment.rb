class Comment < ActiveRecord::Base
	
	belongs_to 	:creator, :class_name => "User", :foreign_key => "created_by"
	belongs_to	:commentable, :polymorphic => true

	validates_presence_of 	:message
	
	def self.set(parent,user,options={})
		c 				= parent.comments.new options[:comment]
		c.creator = user
		c
	end
	
	def after_create
		# Stamp the comment if it's a branch comment
		Activity.create(:activible => self, :creator => self.creator, :branch_id => self.commentable.id) if self.commentable.is_a? Branch
		# Deliver notification
		deliver!
	end
	
	#
	# E-mail Notifications
	#
	
	def deliver!
		if 		self.commentable.is_a? Activity then send_to_participants(self.commentable.creator, self.creator)
		elsif self.commentable.is_a? Branch 	then send_to_followers(self.creator)
		end
	end
	
	def deliver(subject,to,from)
		puts "mail sent to #{to.name} from #{from.name}, subject: #{subject}"
		Mailer.deliver_comment_notification(subject, to, from, self)
	end
	
	# sends emails to branch followers
	def send_to_followers(from)
		branch = self.commentable
		branch.users.each do |user|
			deliver("#{from.name} posted a comment on #{branch.name}", user, from) unless user.eql? from
		end
	end
	
	# sends emails to participants of activity (status) comments
	def send_to_participants(owner,from)
		# send an email to the owner of the status post, unless the comment is coming from the creator
		deliver("#{from.name} posted a comment on your status", owner, from) unless owner.eql? from
		# iterate through all the collaborators and send an email to all, unless the comment is coming from the creator
		self.commentable.comments.collaborators.each do |user|
			unless user.eql? owner or user.eql? from
				if owner.eql? from
					deliver("#{from.name} posted a comment on their status", user, from) 
				else
					deliver("#{from.name} posted a comment on #{owner.name} status", user, from) 
				end
			end
		end
	end
	
end
