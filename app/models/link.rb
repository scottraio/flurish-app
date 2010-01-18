class Link < ActiveRecord::Base
	
	belongs_to 	:creator, :class_name => "User", :foreign_key => "created_by"
	belongs_to	:element
	
	validates_presence_of 	:url
	
end
