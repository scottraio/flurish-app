class Message < ActiveRecord::Base
	
	belongs_to		:recipient, :class_name => "User", :foreign_key => "recipient_id"
	belongs_to		:messenger, :class_name => "User", :foreign_key => "messenger_id"
	
	validates_presence_of 		:username
	
end
