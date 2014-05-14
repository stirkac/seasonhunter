class Comment < ActiveRecord::Base

	# message
	# show_id
	# season
	# episode
	# user

	# Comment.for_show(1234).show_only
	scope :for_show, ->(show_id){ where(show_id: show_id) }
	scope :show_only, ->{ where(episode: nil) }

	# Comment.for_show(1234).season(1).episode(1)
	scope :season, ->(season){ where(season: season.to_i) }
	scope :episode, ->(episode){ where(episode: episode.to_i) }

	belongs_to :user

	validates_presence_of :show_id
	validates_presence_of :message
	validates_presence_of :user

	validates_presence_of :season, if: :episode_comment?

	def series_comment?
		episode.nil?
	end

	def episode_comment?
		episode.present?
	end

end
