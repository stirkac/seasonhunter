class User < ActiveRecord::Base

	## Users attributes
	#
	# name
	# uid
	# provider
	#

	has_many :favorites

	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.uid = auth["uid"]
	    user.name = auth["info"]["name"]
	  end
	end
end
