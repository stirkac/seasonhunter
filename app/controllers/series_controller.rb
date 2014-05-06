class SeriesController < ApplicationController

	expose(:series) do
		if params[:id].present?
			Tmdb::TV.detail params[:id]
		elsif params[:series_id].present?
			Tmdb::TV.detail params[:series_id]
		end
	end

	expose(:seasons) do
		(1..series.number_of_seasons).map do |i|
			Tmdb::Season.detail series.id, i
		end
	end

	def show
	end

	def favorite
		Favorite.find_or_create_by(user_id: current_user.id, show_id: series.id)
		redirect_to series_path(series.id)
	end

	def unfavorite
		Favorite.where(user_id: current_user.id, show_id: series.id).delete_all
		redirect_to series_path(series.id)
	end

end
