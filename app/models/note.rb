class Note < ActiveRecord::Base
	
	belongs_to	:element
	
	def self.get(element,user,options={})
		n 						= self.find(options[:id])
		n.element 		= element
		n.attributes	= options[:note]
		n
	end
	
	def self.set(element,user,options={})
		n 				= self.new(options[:note])
		n.element = element
		n
	end
	
end
