class SearchController < ApplicationController

	expose(:search) do
		if params[:q].present?
			Tmdb::TV.find(params[:q])
		end
	end


def index
end

end
