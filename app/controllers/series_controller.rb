class SeriesController < ApplicationController

	expose(:series) do
		Tmdb::TV.detail params[:id]
	end

	expose(:seasons) do
		(1..series.number_of_seasons).map do |i|
			Tmdb::Season.detail series.id, i
		end
	end

	def show
	end

end
