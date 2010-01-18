class Task < ActiveRecord::Base
	
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	belongs_to	:delegate,	:class_name => "User", :foreign_key => "assigned_to"
	belongs_to	:element
	 
	
	validates_presence_of 	:due_date
	validates_presence_of 	:priority
	validates_presence_of 	:subject
	validates_presence_of 	:description
	validates_presence_of 	:assigned_to
	
end
