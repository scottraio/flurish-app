class Image < ActiveRecord::Base
	
	belongs_to 	:creator, :class_name => "User", :foreign_key => "created_by"
	belongs_to	:element
	
end
