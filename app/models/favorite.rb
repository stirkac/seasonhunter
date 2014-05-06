class Favorite < ActiveRecord::Base

	## Favorite attributes
	#
	# user_id
	# show_id (EXT)
	#

	belongs_to :user

	def show
		Tmdb::TV.detail show_id
	end

end
