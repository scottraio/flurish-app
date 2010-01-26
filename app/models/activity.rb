class Activity < ActiveRecord::Base
	
	belongs_to	:activible, :polymorphic => true
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	belongs_to 	:branch
	belongs_to	:element
	
	has_many		:comments, :as => :commentable

end


