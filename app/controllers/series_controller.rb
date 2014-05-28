class SeriesController < ApplicationController

	expose(:series) do
		Tmdb::TV.detail series_id
	end

	expose(:seasons) do
		(1..series.number_of_seasons).map do |i|
			Tmdb::Season.detail series.id, i
		end
	end

	expose(:comments) do
		Comment.for_show(series_id).show_only
	end

	expose(:ratings) do
		Rating.for_show(series_id).show_only.average(:score)
	end

	def show
		if series.id.nil?
			render :error
		end
	end

	def add_season_to_calendar
		season = Tmdb::Season.detail series_id, params[:season].to_i
		client = current_user.google_api
		season["episodes"].each do |e|
			if e["episode_number"].is_a? Fixnum
				ep = Episode.new series_id, params[:season].to_i, e["episode_number"]
				Google::Calendar.insert_event client, ep
			end
		end
		redirect_to series_path(series.id)
	end

	def favorite
		Favorite.find_or_create_by(user_id: current_user.id, show_id: series.id)
		redirect_to series_path(series.id)
	end

	def unfavorite
		Favorite.where(user_id: current_user.id, show_id: series.id).delete_all
		redirect_to series_path(series.id)
	end

	def create_comment
		comment = Comment.create!(
			message: params[:comment][:message],
			show_id: series_id,
			user: current_user
		)

		redirect_to series_path(series_id)
	end

	def update_rating
		rating = Rating.find_or_initialize_by(show_id: series_id, user_id: current_user.id)
		rating.score = params[:score]
		rating.save!
    respond_to do |format|
        format.json { head :ok }
    end
  end

	private

	def series_id
		if params[:id].present?
			params[:id]
		elsif params[:series_id].present?
			params[:series_id]
		end
	end

end
