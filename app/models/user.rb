class User < ActiveRecord::Base

	## Users attributes
	#
	# name
	# uid
	# provider
	# email
	# image_url
	# gender
	#

	has_many :favorites
	has_many :comments
	has_many :ratings

	def has_favored? show_id
		favorites.find_by(show_id: show_id).present?
	end

	def male?
		gender == 'male' || gender.nil?
	end

	def self.create_with_omniauth(auth)
	  create! do |user|
	    user.provider = auth["provider"]
	    user.token = auth["credentials"]["token"]
	    user.uid = auth["uid"]
	    user.name = auth["info"]["name"]
	    user.email = auth["info"]["email"]
	    user.image_url = auth["info"]["image"]
	    user.gender = (auth["extra"]["raw_info"]["gender"] rescue nil)
	  end
	end
end
