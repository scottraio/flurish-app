class Attachment < ActiveRecord::Base
	
	belongs_to 	:user
	belongs_to	:element
	
end
