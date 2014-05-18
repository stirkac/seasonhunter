class Rating < ActiveRecord::Base
	#show_id: integer
	#season: integer
	#episode: integer
	#user: integer
	#score: integer

	# Rating.for_show(1234).show_only
	scope :for_show, ->(show_id){ where(show_id: show_id) }
	scope :show_only, ->{ where(episode: nil) }

	# Rating.for_show(1234).season(1).episode(1)
	scope :season, ->(season){ where(season: season.to_i) }
	scope :episode, ->(episode){ where(episode: episode.to_i) }

	scope :by_user, ->(user){ where(user_id: user)}

	belongs_to :user

	validates_presence_of :show_id
	validates_presence_of :score
	validates_presence_of :user

	validates_presence_of :season, if: :episode_rating?

	def series_rating?
		episode.nil?
	end

	def episode_rating?
		episode.present?
	end

end
