class Link < ActiveRecord::Base
	
	belongs_to 	:creator, :class_name => "User", :foreign_key => "created_by"
	belongs_to	:element
	
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	
	validates_presence_of 	:name
	validates_presence_of 	:url
	validates_format_of     :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
	
	def self.get(element,user,options={})
		l 						= self.find(options[:id])
		l.element 		= element
		l.creator 		= user
		l.attributes	= options[:link]
		l
	end
	
	def self.set(element,user,options={})
		l 				= self.new(options[:link])
		l.element = element
		l.creator = user
		l
	end
	
end
