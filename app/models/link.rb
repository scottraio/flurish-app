class Link < ActiveRecord::Base
	
	belongs_to 	:creator, :class_name => "User", :foreign_key => "created_by"
	belongs_to	:element
	
	validates_presence_of 	:url
	
	def self.get(element,user,options={})
		l 						= self.find(options[:id])
		l.element 		= element
		l.attributes	= options[:link]
		l
	end
	
	def self.set(element,user,options={})
		l 				= self.new(options[:link])
		l.element = element
		l
	end
	
end
