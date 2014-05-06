class User < ActiveRecord::Base

	## Users attributes
	#
	# name
	# uid
	# provider
	#

	has_many :favorites

	def has_favored? show_id
		favorites.find_by(show_id: show_id).present?
	end

	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.uid = auth["uid"]
	    user.name = auth["info"]["name"]
	  end
	end
end
