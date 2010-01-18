class Element < ActiveRecord::Base
	
	belongs_to	:branch
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
	
	
	
end
