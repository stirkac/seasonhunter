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
    rating = Rating.for_show(series_id).by_user(current_user)
    if rating.empty?
    	Rating.create!(
    		score: params[:score],
				show_id: series_id,
				user: current_user
    	)
    else
    	rating.update_all(score: params[:score].to_i)
    end
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
