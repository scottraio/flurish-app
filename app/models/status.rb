class Status < ActiveRecord::Base
	
	has_one			:activity, :as => :activible
	belongs_to 	:user
	
	validates_presence_of :message
	
	def self.set(user,options={})
		user.statuses.new(options[:statuses])
	end
	
	def self.get(user,options={})
		user.statuses.find(options[:id])
	end
	
	def after_create
		Activity.create(:activible => self, :creator => self.user)
		self.user.update_attributes(:has_status => 1)
	end
	
end
