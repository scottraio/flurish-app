class Branch < ActiveRecord::Base
	
	belongs_to 	:organization
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	
	has_and_belongs_to_many :users
	
	has_many		:comments, :as => :commentable
	
	has_many		:elements
	has_many		:element_types, :through => :elements
	
	has_one			:note,				:through => :elements
	
	has_many		:activities, 	:through => :elements
	has_many		:attachments, :through => :elements
	has_many		:events, 			:through => :elements
	has_many		:images,			:through => :elements
	has_many		:links,				:through => :elements
	has_many		:locations,		:through => :elements
	has_many		:videos,			:through => :elements
	has_many		:tasks,				:through => :elements
	
	validates_presence_of 	:name
	validates_presence_of 	:description
	
	def self.get(user,params)
		b	 						= self.find(params[:id])
		b.attributes 	= params[:branch]
		b
	end
	
	def self.set(user,params)
		b 							= self.new(params[:branch])
		b.creator 			= user
		b.organization 	= user.organization
		b
	end
	
	def attach(element)
		elements << element
		self.save
	end
	
	def has?(element)
		names = self.element_types.collect{|et| et.name.downcase.to_sym }
		names.include?(element) ? true : false
	end
	
end
