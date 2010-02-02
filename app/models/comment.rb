class Comment < ActiveRecord::Base
	
	belongs_to 	:creator, :class_name => "User", :foreign_key => "created_by"
	belongs_to	:commentable, :polymorphic => true

	validates_presence_of 	:message
	
	def self.set(parent,user,options={})
		c 				= parent.comments.new options[:comment]
		c.creator = user
		c
	end
	
end
