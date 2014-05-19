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
		Raing.for_show(params[:series_id]).season(params[:season]).episode(params[:episode])
	end

	def show
		if episode['status_code'].present?
			render :error
		end
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

end
