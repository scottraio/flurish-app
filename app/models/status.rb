class Status < ActiveRecord::Base
	
	has_one			:activity, :as => :activible
	belongs_to 	:user
	
	validates_presence_of :message
	
	def self.set(user,params)
		user.statuses.new(params[:statuses])
	end
	
	def after_create
		Activity.create(:activible => self, :creator => self.user)
	end
	
end
