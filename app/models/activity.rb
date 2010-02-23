class Activity < ActiveRecord::Base
	
	belongs_to	:activible, :polymorphic => true
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	belongs_to 	:topic
	belongs_to	:element
	
	has_many		:comments, :as => :commentable do
		def collaborators
			self.collect{|comment| comment.creator }.uniq 
		end
	end
	
	def self.sql(kind,user)
		case kind
			when :conditions then build_conditions_sql(user)
		end
	end
	
	def self.build_conditions_sql(user,sql=[])
		# include all leaders
		sql << 	"activities.created_by IN (#{(user.leaders.collect{|u| u.id } << user.id).uniq.join(",")})" 
		# only include topic activity for the stuff we're following, do not run this
		# sql statement if the user is not following any topics
		sql << 	"OR activities.topic_id IN (#{user.topics.collect{|b| b.id }.uniq.join(",")})" unless user.topics.empty?
		sql.join(" ")
	end

end


