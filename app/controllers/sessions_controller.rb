class SessionsController < ApplicationController
	def create
		auth =  request.env["omniauth.auth"]
		user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])

		if user.present? # Always update users token
			user.update_attributes(token: auth["credentials"]["token"])
		else
			user = User.create_with_omniauth(auth)
		end

		session[:user_id] = user.id
  	redirect_to (request.env["omniauth.origin"] || root_url)
	end

	def destroy
		session[:user_id] = nil
  	redirect_to (request.env["HTTP_REFERER"] || root_url)
	end
end
