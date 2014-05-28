class EpisodesController < ApplicationController

	expose(:series) do
		Tmdb::TV.detail params[:series_id]
	end

	expose(:episode) do
		Tmdb::Episode.detail params[:series_id], params[:season], params[:episode]
	end

	expose(:comments) do
		Comment.for_show(params[:series_id]).season(params[:season]).episode(params[:episode])
	end

	expose(:ratings) do
		Rating.for_show(params[:series_id]).season(params[:season]).episode(params[:episode]).average(:score)
	end

	def show
		if episode['status_code'].present?
			render :error
		end
	end

	def add_to_calendar
		ep = Episode.new params[:series_id], params[:season], params[:episode]
		client = current_user.google_api

		Google::Calendar.insert_event client, ep
		redirect_to series_episode_path(params[:series_id],params[:season],params[:episode])
	end

	def create_comment
		comment = Comment.create!(
			message: params[:comment][:message],
			show_id: params[:series_id],
			season: params[:season],
			episode: params[:episode],
			user: current_user
		)

		redirect_to series_episode_path(params[:series_id],params[:season],params[:episode])
	end

	def update_rating
		rating = Rating.find_or_initialize_by(
			show_id: params[:series_id],
			user_id: current_user.id,
			season: params[:season],
			episode: params[:episode],
			)
		rating.score = params[:score]
		rating.save!
    respond_to do |format|
        format.json { head :ok }
    end
  end

end
