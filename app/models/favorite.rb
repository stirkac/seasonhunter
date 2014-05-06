class Favorite < ActiveRecord::Base

	## Favorite attributes
	#
	# user_id
	# show_id (EXT)
	#

	belongs_to :user

	def get_show
		# Get show from TVDB
	end

end
