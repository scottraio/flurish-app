class Organization < ActiveRecord::Base
	
	has_many 	:users
	has_many 	:branches
	has_many	:groups
	
	validates_presence_of 		:name
	
	
	
end
