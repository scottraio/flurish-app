class Topic < ActiveRecord::Base
	
	acts_as_taggable_on :tags
	
	belongs_to 	:organization
	belongs_to 	:creator, 	:class_name => "User", :foreign_key => "created_by"
	
	has_and_belongs_to_many :users
	
	has_many		:comments, :as => :commentable
	
	has_many		:elements
	has_many		:element_types, :through => :elements
	
	has_one			:note,				:through => :elements
	
	has_many		:activities, 	:through => :elements
	has_many		:attachments, :through => :elements
	has_many		:events, 			:through => :elements
	has_many		:images,			:through => :elements
	has_many		:links,				:through => :elements
	has_many		:locations,		:through => :elements
	has_many		:videos,			:through => :elements
	has_many		:tasks,				:through => :elements
	
	validates_presence_of 	:name
	validates_presence_of 	:description

	attr_accessor :invitees
	
	named_scope :by_organization, lambda { |org_id|
		{ :conditions => { :organization_id => org_id }, :order => "created_at DESC" }
	}
	
	def after_create
		self.users << self.creator
	end
	
	def self.get(user,params)
		t	 						= self.find(params[:id], :include => [{:comments => :creator}])
		t.attributes 	= params[:topic]
		t
	end
	
	def self.set(user,params)
		t 							= self.new(params[:topic])
		t.creator 			= user
		t.organization 	= user.organization
		t
	end
	
	def attach(element)
		elements << element
		self.save
	end
	
	def has?(element)
		names = self.element_types.collect{|et| et.name.downcase.to_sym }
		names.include?(element) ? true : false
	end
	
	def self.get_all(user,options={})
		if options[:tag] then tagged_with(options[:tag]).by_organization(user.organization_id)
		else by_organization(user.organization_id)
		end 
	end
	
end
