class Task < ActiveRecord::Base
	
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	belongs_to	:delegate,	:class_name => "User", :foreign_key => "assigned_to"
	belongs_to	:element
	 
	
	validates_presence_of 	:priority
	validates_presence_of 	:subject
	validates_presence_of 	:description
	
	def self.get(element,user,options={})
		t 						= self.find(options[:id])
		t.element 		= element
		t.creator 		= user
		t.attributes	= options[:task]
		t
	end
	
	def self.set(element,user,options={})
		t 				= self.new(options[:task])
		t.element = element
		t.creator = user
		t
	end
	
end
