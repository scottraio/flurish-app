require 'digest/sha2'

class User < ActiveRecord::Base
	
	has_attached_file :avatar, :styles => { :medium => "200x200>", :thumb => "50x50>" }, :url => "/:class/:attachment/:id/:style_:basename.:extension", :path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension"
	
	has_and_belongs_to_many :followers, :class_name => "User", :foreign_key => "followee_id", :association_foreign_key => "follower_id"
	has_and_belongs_to_many :leaders, 	:class_name => "User", :foreign_key => "follower_id", :association_foreign_key => "followee_id"
	
	has_and_belongs_to_many :groups
	has_and_belongs_to_many :branches
	
	has_many		:activities, 		:class_name => "Activity", 	:foreign_key 	=> "created_by"
	has_many		:originals, 		:class_name => "Branch", 		:foreign_key 	=> "created_by"
	has_many		:messages, 			:class_name => "Message", 	:foreign_key 	=> "recipient_id"
	has_many		:compositions, 	:class_name => "Message", 	:foreign_key 	=> "messenger_id"
	has_many		:assignments, 	:class_name => "Task", 			:foreign_key 	=> "assigned_to"
	
	has_many		:statuses
	has_many		:attachments
	has_many		:comments
	has_many		:events
	has_many		:images
	has_many		:links
	has_many		:locations
	has_many		:videos
	has_many		:notes
	has_many		:tasks
	
  attr_accessor 	:password_confirmation
	attr_protected 	:password

	validates_presence_of 		:name
  validates_presence_of 		:login
  validates_presence_of 		:password, 								:if => :password_required?
  validates_presence_of 		:password_confirmation, 	:if => :password_required?
  validates_confirmation_of :password, 								:if => :password_required?


	def self.get(user,params={})
		self.find(user.id)
	end
	
	def self.set(user,params={})
		u = self.new(params[:user])
	end
	
	def follow(something)
		if 		something.is_a? User	then (self.leaders << something)
		elsif something.is_a? Group	then (self.groups << something)
		elsif something.is_a? Topic	then (self.topics << something)
		end
	end
	
	def feed
		self.activities.find(:all, :include => [:activible, {:element => :branch}], :order => "activities.created_at DESC")
	end
	
	def current_status
		status = self.statuses.find(:first, :order => "statuses.created_at DESC")
		status.nil? ? "No current status" : status.message
	end
	
	#
	# Authentication Methods
	#
	
  def before_save
    self.password = User.encrypt(password) if not self.password.blank?
  end
  
  def password_required?
    self.password.blank?
  end
  
  def self.encrypt(string)
    return Digest::SHA256.hexdigest(string)
  end
  
  def self.authenticate(username, password)
    find_by_login_and_password(username, self.encrypt(password))
  end
	
end
