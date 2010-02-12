class Activity < ActiveRecord::Base
	
	belongs_to	:activible, :polymorphic => true
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	belongs_to 	:branch
	belongs_to	:element
	
	has_many		:comments, :as => :commentable
	
	def self.sql(kind,user)
		case kind
			when :conditions then build_conditions_sql(user)
		end
	end
	
	def self.build_conditions_sql(user,sql=[])
		# include all leaders
		sql << 	"activities.created_by IN (#{(user.leaders.collect{|u| u.id } << user.id).uniq.join(",")})" 
		# only include branch activity for the stuff we're following, do not run this
		# sql statement if the user is not following any branches
		sql << 	"OR activities.branch_id IN (#{user.branches.collect{|b| b.id }.uniq.join(",")})" unless user.branches.empty?
		sql.join(" ")
	end

end


