class Note < ActiveRecord::Base
	
	belongs_to	:element
	
	validates_presence_of 	:body
	
end
