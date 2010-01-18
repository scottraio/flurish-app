class Branch < ActiveRecord::Base
	
	has_and_belongs_to_many :users
	
	has_many		:elements
	
	has_many		:activities, 	:through => :elements
	has_many		:attachments, :through => :elements
	has_many		:comments,		:through => :elements
	has_many		:events, 			:through => :elements
	has_many		:images,			:through => :elements
	has_many		:links,				:through => :elements
	has_many		:locations,		:through => :elements
	has_many		:videos,			:through => :elements
	has_many		:notes,				:through => :elements
	has_many		:tasks,				:through => :elements
	
	validates_presence_of 	:name
	validates_presence_of 	:description
	
end
