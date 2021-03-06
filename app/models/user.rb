require 'digest/sha2'

class User < ActiveRecord::Base
	
	has_attached_file :avatar, :styles => { :large => "200x200>", :thumb => "48x48#", :medium => "32x32#", :small => "24x24#", :tiny => "16x16#" }, :url => "/:class/:attachment/:id/:style_:basename.:extension", :path => ":rails_root/public/:class/:attachment/:id/:style_:basename.:extension"
	
	belongs_to :organization
	
	has_and_belongs_to_many :followers, :class_name => "User", :foreign_key => "followee_id", :association_foreign_key => "follower_id"
	has_and_belongs_to_many :leaders, 	:class_name => "User", :foreign_key => "follower_id", :association_foreign_key => "followee_id"
	
	has_and_belongs_to_many :groups
	has_and_belongs_to_many :topics
	
	has_many		:activities, 		:class_name => "Activity", 	:foreign_key 	=> "created_by"
	has_many		:originals, 		:class_name => "Branch", 		:foreign_key 	=> "created_by"
	has_many		:messages, 			:class_name => "Message", 	:foreign_key 	=> "recipient_id"
	has_many		:compositions, 	:class_name => "Message", 	:foreign_key 	=> "messenger_id"
	has_many		:assignments, 	:class_name => "Task", 			:foreign_key 	=> "assigned_to"
	
	has_many		:statuses, :order => "statuses.created_at DESC"
	has_many		:attachments
	has_many		:comments
	has_many		:events
	has_many		:images
	has_many		:links
	has_many		:locations
	has_many		:videos
	has_many		:notes
	has_many		:tasks
	
  attr_accessor 	:password, :password_confirmation
	attr_protected 	:hashed_password

	validates_presence_of 		:first_name
	validates_presence_of 		:last_name
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
	
	def name
		"#{self.first_name} #{self.last_name}"
	end
	
	def follow(something)
		if 		something.is_a? User		then (self.leaders << something)
		elsif something.is_a? Group		then (self.groups << something)
		elsif something.is_a? Topic		then (self.topics << something)
		end
	end
	
	def stop_following(something)
		if 		something.is_a? User		then (self.leaders.delete something)
		elsif something.is_a? Group		then (self.groups.delete something)
		elsif something.is_a? Topic		then (self.topics.delete something)
		end
	end
	
	def following?(something)
		if 		something.is_a? User		then (return true if self.leaders.include? something)
		elsif something.is_a? Group		then (return true if self.groups.include? something)
		elsif something.is_a? Topic		then (return true if self.topics.include? something)
		end
	end
	
	def feed
		# Factory method for grabbing activities for users
		Activity.feed_for self 
	end
	
	def current_status
		status = self.statuses.first
		status.nil? ? "No current status" : status.message
	end
	
	#
	# Authentication Methods
	#
	
  def before_save
    self.hashed_password = User.encrypt(password) if not self.password.blank?
  end
  
  def password_required?
    self.hashed_password.blank? || !self.password.blank?
  end
  
  def self.encrypt(string)
    return Digest::SHA256.hexdigest(string)
  end
  
  def self.authenticate(username, password)
    find_by_login_and_hashed_password(username, self.encrypt(password))
  end
	
end
