class Element < ActiveRecord::Base
	
	belongs_to	:topic
	belongs_to	:element_type
	
	has_many		:activities
	has_many		:attachments
	has_many		:comments
	has_many		:events
	has_many		:images
	has_many		:links
	has_many		:locations
	has_many		:tasks
	has_many		:videos
	has_one			:note
	
	def self.set(type,user,options={})
		e 							= self.new(options[:elements])
		e.element_type 	= type
		e
	end
	
	def system_name
		self.element_type.name.downcase
	end
	
end
