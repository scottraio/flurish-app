class Group < ActiveRecord::Base
	
	has_and_belongs_to_many 	:users
	
	belongs_to 	:creator, :class_name => "User", :foreign_key => "created_by"
	
end
